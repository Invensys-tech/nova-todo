class Partner {
  final int id;
  final String name;
  final String phone_number;
  final String? created_at;

  Partner({
    required this.id,
    required this.name,
    required this.phone_number,
    this.created_at,
  });
  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'] as int,
      name: json['name'] as String,
      phone_number: json['phone_number'] as String,
      created_at: json['created_at'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phone_number;
    data['created_at'] = created_at;
    return data;
  }
}
