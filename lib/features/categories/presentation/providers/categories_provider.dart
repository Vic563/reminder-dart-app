import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../database/database.dart';
import '../../../reminders/presentation/providers/reminders_provider.dart';
import '../../domain/entities/category_entity.dart';

part 'categories_provider.g.dart';

CategoryEntity _toEntity(Category c) {
  return CategoryEntity(
    id: c.id,
    name: c.name,
    colorValue: c.color,
    iconName: c.iconName,
    createdAt: c.createdAt,
  );
}

@riverpod
Future<List<CategoryEntity>> categories(Ref ref) async {
  final db = ref.watch(databaseProvider);
  final dbCategories = await db.getAllCategories();
  return dbCategories.map(_toEntity).toList();
}

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  FutureOr<void> build() {}

  Future<int> addCategory({
    required String name,
    required int colorValue,
    String? iconName,
  }) async {
    final db = ref.read(databaseProvider);

    final id = await db.insertCategory(
      CategoriesCompanion.insert(
        name: name,
        color: colorValue,
        iconName: Value(iconName),
        createdAt: DateTime.now(),
      ),
    );

    ref.invalidate(categoriesProvider);
    return id;
  }

  Future<void> updateCategory({
    required int id,
    required String name,
    required int colorValue,
    String? iconName,
  }) async {
    final db = ref.read(databaseProvider);

    await db.updateCategory(
      CategoriesCompanion(
        id: Value(id),
        name: Value(name),
        color: Value(colorValue),
        iconName: Value(iconName),
      ),
    );

    ref.invalidate(categoriesProvider);
  }

  Future<void> deleteCategory(int id) async {
    final db = ref.read(databaseProvider);
    await db.deleteCategory(id);
    ref.invalidate(categoriesProvider);
  }
}
