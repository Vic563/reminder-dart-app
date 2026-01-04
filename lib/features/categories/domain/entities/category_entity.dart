import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';
part 'category_entity.g.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  const CategoryEntity._();

  const factory CategoryEntity({
    int? id,
    required String name,
    required int colorValue,
    String? iconName,
    required DateTime createdAt,
  }) = _CategoryEntity;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Color get color => Color(colorValue);

  IconData? get icon {
    if (iconName == null) return null;
    // Map common icon names to IconData
    switch (iconName) {
      case 'work':
        return Icons.work;
      case 'person':
        return Icons.person;
      case 'health':
      case 'favorite':
        return Icons.favorite;
      case 'money':
      case 'attach_money':
        return Icons.attach_money;
      case 'shopping':
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'home':
        return Icons.home;
      case 'school':
        return Icons.school;
      case 'sports':
      case 'fitness_center':
        return Icons.fitness_center;
      case 'travel':
      case 'flight':
        return Icons.flight;
      case 'food':
      case 'restaurant':
        return Icons.restaurant;
      default:
        return Icons.label;
    }
  }
}
