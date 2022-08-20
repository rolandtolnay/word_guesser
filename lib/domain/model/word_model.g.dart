// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordModel _$WordModelFromJson(Map<String, dynamic> json) => WordModel(
      json['id'] as String,
      Map<String, String>.from(json['languages'] as Map),
      json['imageUrl'] as String,
    );

Map<String, dynamic> _$WordModelToJson(WordModel instance) => <String, dynamic>{
      'id': instance.id,
      'languages': instance.languages,
      'imageUrl': instance.imageUrl,
    };
