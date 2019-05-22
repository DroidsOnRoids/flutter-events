// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speaker _$SpeakerFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'avatar', 'name', 'job', 'bio'],
      disallowNullValues: const ['id', 'avatar', 'name', 'job', 'bio']);
  return Speaker(
      id: json['id'] as int,
      avatar: json['avatar'] == null
          ? null
          : Photo.fromJson(json['avatar'] as Map<String, dynamic>),
      name: json['name'] as String,
      job: json['job'] as String,
      bio: json['bio'] as String,
      email: json['email'] as String,
      githubUrl: json['github_url'] as String,
      websiteUrl: json['website_url'] as String,
      twitterUrl: json['twitter_url'] as String,
      talks: (json['talks'] as List)
          ?.map((e) =>
              e == null ? null : Talk.fromJson(e as Map<String, dynamic>))
          ?.toList());
}
