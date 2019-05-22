// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['big', 'thumb'],
      disallowNullValues: const ['big', 'thumb']);
  return Photo(big: json['big'] as String, thumb: json['thumb'] as String);
}
