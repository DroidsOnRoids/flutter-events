// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'title', 'date', 'cover_images'],
      disallowNullValues: const ['id', 'title', 'date', 'cover_images']);
  return Event(
      id: json['id'] as int,
      title: json['title'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      facebook: json['facebook'] as String,
      placeName: json['place_name'] as String,
      placeStreet: json['place_street'] as String,
      coverImages: (json['cover_images'] as List)
          ?.map((e) =>
              e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      photos: (json['photos'] as List)
          ?.map((e) =>
              e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      placeCoordinates: json['place_coordinates'] == null
          ? null
          : Coordinates.fromJson(
              json['place_coordinates'] as Map<String, dynamic>),
      talks: (json['talks'] as List)
          ?.map((e) =>
              e == null ? null : Talk.fromJson(e as Map<String, dynamic>))
          ?.toList());
}
