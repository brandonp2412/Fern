import 'package:flutter/material.dart';
import '../models/connection.dart';
import '../services/akahu_api.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ConnectionsScreen extends StatefulWidget {
  final AkahuApi api;

  const ConnectionsScreen({super.key, required this.api});

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends State<ConnectionsScreen> {
  List<Connection>? _connections;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final connections = await widget.api.getConnections();
      connections.sort((a, b) => a.name.compareTo(b.name));
      if (mounted) setState(() => _connections = connections);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connections')),
      body: _connections == null && _error == null
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? ErrorState(error: _error!, onRetry: _load)
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: _connections!.length,
                  itemBuilder: (context, i) {
                    final c = _connections![i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LogoAvatar(url: c.logo, size: 44),
                            const SizedBox(height: 8),
                            Text(
                              c.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            if (!c.newConnectionsEnabled) ...[
                              const SizedBox(height: 4),
                              const Text('Unavailable',
                                  style: TextStyle(
                                      fontSize: 10, color: Fern.clay)),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
