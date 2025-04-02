import 'dart:convert';

class Note {
  int id;
  String title;
  String notes;
  String color;
  Note({
    required this.title,
    required this.notes,
    required this.id,
    required this.color,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['notes'] = {'notes': notes};
    data['id'] = id;
    data['color'] = color;
    return data;
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'] as String,
      notes: jsonEncode(json['notes']),
      id: json['id'] as int,
      color: json['color'] as String,
    );
  }
}
