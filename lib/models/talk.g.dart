// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Talk _$TalkFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'title', 'description'],
      disallowNullValues: const ['id', 'title', 'description']);
  return Talk(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
      speaker: json['speaker'] == null
          ? null
          : Speaker.fromJson(json['speaker'] as Map<String, dynamic>),
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>));
}
