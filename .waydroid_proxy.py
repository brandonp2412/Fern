import select
import socket
import socketserver
import sys
from urllib.parse import urlsplit


class ProxyHandler(socketserver.StreamRequestHandler):
    timeout = 20

    def _relay(self, upstream: socket.socket) -> None:
        peers = [self.connection, upstream]
        while True:
            readable, _, _ = select.select(peers, [], [], 30)
            if not readable:
                return
            for source in readable:
                data = source.recv(65536)
                if not data:
                    return
                target = upstream if source is self.connection else self.connection
                target.sendall(data)

    def handle(self) -> None:
        first = self.rfile.readline(65536)
        if not first:
            return
        try:
            method, target, version = first.decode('latin1').strip().split(' ', 2)
        except ValueError:
            return

        headers = []
        while True:
            line = self.rfile.readline(65536)
            if line in (b'\r\n', b'\n', b''):
                break
            headers.append(line)

        if method.upper() == 'CONNECT':
            host, port_text = target.rsplit(':', 1)
            port = int(port_text)
            print(f'CONNECT {host}:{port}', flush=True)
            try:
                upstream = socket.create_connection((host, port), timeout=15)
            except OSError as exc:
                self.wfile.write(f'HTTP/1.1 502 Bad Gateway\r\nContent-Length: 0\r\n\r\n'.encode())
                print(f'CONNECT failed {host}:{port}: {exc}', file=sys.stderr, flush=True)
                return
            with upstream:
                self.wfile.write(b'HTTP/1.1 200 Connection Established\r\n\r\n')
                self.wfile.flush()
                self._relay(upstream)
            return

        parsed = urlsplit(target)
        host = parsed.hostname
        if not host:
            for line in headers:
                if line.lower().startswith(b'host:'):
                    host = line.split(b':', 1)[1].strip().decode('latin1').split(':')[0]
                    break
        if not host:
            return
        port = parsed.port or 80
        path = parsed.path or '/'
        if parsed.query:
            path += '?' + parsed.query
        print(f'{method} http://{host}:{port}{path}', flush=True)
        try:
            upstream = socket.create_connection((host, port), timeout=15)
        except OSError:
            self.wfile.write(b'HTTP/1.1 502 Bad Gateway\r\nContent-Length: 0\r\n\r\n')
            return
        with upstream:
            upstream.sendall(f'{method} {path} {version}\r\n'.encode('latin1'))
            for line in headers:
                if not line.lower().startswith(b'proxy-connection:'):
                    upstream.sendall(line)
            upstream.sendall(b'\r\n')
            self._relay(upstream)


class Server(socketserver.ThreadingTCPServer):
    allow_reuse_address = True
    daemon_threads = True


if __name__ == '__main__':
    with Server(('192.168.240.1', 8888), ProxyHandler) as server:
        print('proxy listening on 192.168.240.1:8888', flush=True)
        server.serve_forever()
