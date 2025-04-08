class UserEntity {
  final int? id;
  final String name;
  final String phoneNumber;

  UserEntity({required this.name, required this.phoneNumber, this.id});

  factory UserEntity.fromJson(Map<String, dynamic> userJson) => UserEntity(
    id: userJson['id'],
    name: userJson['name'],
    phoneNumber: userJson['phoneNumber'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
  };
}
