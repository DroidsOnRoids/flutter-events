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

import 'package:events/models/coordinates.dart';
import 'package:events/models/photo.dart';
import 'package:events/models/talk.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Event {
  @JsonKey(required: true, disallowNullValue: true)
  final int id;

  @JsonKey(required: true, disallowNullValue: true)
  final String title;

  @JsonKey(required: true, disallowNullValue: true)
  final DateTime date;

  final String facebook;

  final String placeName;

  final String placeStreet;

  @JsonKey(required: true, disallowNullValue: true)
  final List<Photo> coverImages;

  final List<Photo> photos;

  final Coordinates placeCoordinates;

  final List<Talk> talks;

  Event(
      {this.id,
      this.title,
      this.date,
      this.facebook,
      this.placeName,
      this.placeStreet,
      this.coverImages,
      this.photos,
      this.placeCoordinates,
      this.talks});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
