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
import 'package:events/models/event.dart';
import 'package:events/models/speaker.dart';

part 'talk.g.dart';

@JsonSerializable(createToJson: false)
class Talk {
  @JsonKey(required: true, disallowNullValue: true)
  final int id;

  @JsonKey(required: true, disallowNullValue: true)
  final String title;

  @JsonKey(required: true, disallowNullValue: true)
  final String description;

  final List<String> tags;
  final Speaker speaker;
  final Event event;

  Talk(
      {this.id,
      this.title,
      this.description,
      this.tags,
      this.speaker,
      this.event});

  factory Talk.fromJson(Map<String, dynamic> json) => _$TalkFromJson(json);
}
