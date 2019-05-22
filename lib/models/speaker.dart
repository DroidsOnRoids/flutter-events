//
//  Copyright 2019 Droids On Roids
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import 'package:json_annotation/json_annotation.dart';
import 'package:events/models/photo.dart';
import 'package:events/models/talk.dart';

part 'speaker.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Speaker {
  @JsonKey(required: true, disallowNullValue: true)
  final int id;

  @JsonKey(required: true, disallowNullValue: true)
  final Photo avatar;

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final String job;

  @JsonKey(required: true, disallowNullValue: true)
  final String bio;

  final String email;

  final String githubUrl;

  final String websiteUrl;

  final String twitterUrl;

  final List<Talk> talks;

  Speaker(
      {this.id,
      this.avatar,
      this.name,
      this.job,
      this.bio,
      this.email,
      this.githubUrl,
      this.websiteUrl,
      this.twitterUrl,
      this.talks});

  factory Speaker.fromJson(Map<String, dynamic> json) =>
      _$SpeakerFromJson(json);
}
