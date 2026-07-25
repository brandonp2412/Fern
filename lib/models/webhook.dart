class Webhook {
  final String id;
  final String? state;
  final String? url;
  final String? lastCalledAt;
  final String? createdAt;

  Webhook({
    required this.id,
    this.state,
    this.url,
    this.lastCalledAt,
    this.createdAt,
  });

  factory Webhook.fromJson(Map<String, dynamic> json) {
    return Webhook(
      id: json['_id'] ?? '',
      state: json['state'],
      url: json['url'],
      lastCalledAt: json['last_called_at'],
      createdAt: json['created_at'],
    );
  }
}

class WebhookEvent {
  final String id;
  final String hook;
  final String status;
  final String? webhookType;
  final String? webhookCode;
  final String? createdAt;
  final String? lastFailedAt;

  WebhookEvent({
    required this.id,
    this.hook = '',
    required this.status,
    this.webhookType,
    this.webhookCode,
    this.createdAt,
    this.lastFailedAt,
  });

  factory WebhookEvent.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'];
    return WebhookEvent(
      id: json['_id'] ?? '',
      hook: json['hook'] ?? '',
      status: json['status'] ?? '',
      webhookType: payload is Map<String, dynamic> ? payload['webhook_type'] : null,
      webhookCode: payload is Map<String, dynamic> ? payload['webhook_code'] : null,
      createdAt: json['created_at'],
      lastFailedAt: json['last_failed_at'],
    );
  }
}
