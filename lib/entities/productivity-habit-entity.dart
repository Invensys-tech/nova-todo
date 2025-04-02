class ProductivityHabit {
  int id;
  String title;
  int productivity_id;

  ProductivityHabit({
    required this.id,
    required this.title,
    required this.productivity_id,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['productivity_id'] = productivity_id;
    return data;
  }

  factory ProductivityHabit.fromJson(Map<String, dynamic> json) {
    return ProductivityHabit(
      id: json['id'] as int,
      title: json['title'] as String,
      productivity_id: json['productivity_id'] as int,
    );
  }
}
