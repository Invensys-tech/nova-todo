import 'package:flutter/widgets.dart';

class FormInput {
  final String label;
  final String hint;
  final String type;
  final TextEditingController controller;
  final double span;

  FormInput({
    required this.label,
    required this.hint,
    required this.type,
    required this.controller,
    this.span = 3,
  });
}
