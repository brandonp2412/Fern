class User {
  final String id;
  final String? email;
  final String? accessGrantedAt;

  User({required this.id, this.email, this.accessGrantedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      email: json['email'],
      accessGrantedAt: json['access_granted_at'],
    );
  }
}
