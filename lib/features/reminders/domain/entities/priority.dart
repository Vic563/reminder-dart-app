import 'package:flutter/material.dart';

enum Priority {
  low(0, 'Low', Colors.green),
  medium(1, 'Medium', Colors.orange),
  high(2, 'High', Colors.red);

  const Priority(this.value, this.label, this.color);

  final int value;
  final String label;
  final Color color;

  static Priority fromValue(int value) {
    return Priority.values.firstWhere(
      (p) => p.value == value,
      orElse: () => Priority.medium,
    );
  }
}
