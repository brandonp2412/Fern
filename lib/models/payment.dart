class PaymentTo {
  final String? accountNumber;
  final String? name;

  PaymentTo({this.accountNumber, this.name});

  factory PaymentTo.fromJson(Map<String, dynamic> json) {
    return PaymentTo(
      accountNumber: json['account_number'],
      name: json['name'],
    );
  }
}

class PaymentEvent {
  final String status;
  final String time;
  final String? eta;

  PaymentEvent({required this.status, required this.time, this.eta});

  factory PaymentEvent.fromJson(Map<String, dynamic> json) {
    return PaymentEvent(
      status: json['status'] ?? '',
      time: json['time'] ?? '',
      eta: json['eta'],
    );
  }
}

class Payment {
  final String id;
  final String from;
  final PaymentTo? to;
  final num amount;
  final String? sid;
  final String status;
  final String? statusText;
  final bool final_;
  final List<PaymentEvent> timeline;
  final String? createdAt;
  final String? updatedAt;
  final String? receivedAt;

  Payment({
    required this.id,
    required this.from,
    this.to,
    required this.amount,
    this.sid,
    required this.status,
    this.statusText,
    this.final_ = false,
    this.timeline = const [],
    this.createdAt,
    this.updatedAt,
    this.receivedAt,
  });

  bool get cancellable => status == 'PENDING_APPROVAL';
  bool get isSuccess => status == 'SENT';
  bool get isFailed =>
      const {'DECLINED', 'CANCELLED', 'ERROR'}.contains(status);

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['_id'] ?? '',
      from: json['from'] ?? '',
      to: json['to'] != null ? PaymentTo.fromJson(json['to']) : null,
      amount: json['amount'] is num ? json['amount'] : 0,
      sid: json['sid'],
      status: json['status'] ?? '',
      statusText: json['status_text'],
      final_: json['final'] == true,
      timeline: (json['timeline'] as List<dynamic>?)
              ?.map((e) => PaymentEvent.fromJson(e))
              .toList() ??
          [],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      receivedAt: json['received_at'],
    );
  }
}
