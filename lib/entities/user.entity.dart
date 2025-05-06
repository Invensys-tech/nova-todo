class UserEntity {
  final int? id;
  final String name;
  final String phoneNumber;
  final String? createdAt;
  final String? gender;

  UserEntity({
    required this.name,
    required this.phoneNumber,
    this.id,
    this.createdAt,
    this.gender,
  });

  factory UserEntity.fromJson(Map<String, dynamic> userJson) => UserEntity(
    id: userJson['id'],
    name: userJson['name'],
    phoneNumber: userJson['phoneNumber'],
    createdAt: userJson['created_at'],
    gender: userJson['gender'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
  };
}
