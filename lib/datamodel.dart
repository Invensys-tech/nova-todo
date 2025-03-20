class User {
  int id;
  DateTime createdAt;
  String name;
  String email;
  String phoneNumber;

  User({
    required this.createdAt,
    required this.email,
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return (User(
      id: json['id'] as int,
      createdAt: json['created_at'] as DateTime,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    ));
  }
}
