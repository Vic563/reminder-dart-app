// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryEntityImpl _$$CategoryEntityImplFromJson(Map<String, dynamic> json) =>
    _$CategoryEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      colorValue: (json['colorValue'] as num).toInt(),
      iconName: json['iconName'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CategoryEntityImplToJson(
  _$CategoryEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'colorValue': instance.colorValue,
  'iconName': instance.iconName,
  'createdAt': instance.createdAt.toIso8601String(),
};
