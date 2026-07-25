class Connection {
  final String id;
  final String name;
  final String logo;
  final String? connectionType;
  final bool newConnectionsEnabled;

  Connection({
    required this.id,
    required this.name,
    required this.logo,
    this.connectionType,
    this.newConnectionsEnabled = true,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      connectionType: json['connection_type'],
      newConnectionsEnabled: json['new_connections_enabled'] != false,
    );
  }
}
