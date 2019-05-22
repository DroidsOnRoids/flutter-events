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

part 'photo.g.dart';

@JsonSerializable(createToJson: false)
class Photo {
  @JsonKey(required: true, disallowNullValue: true)
  final String big;

  @JsonKey(required: true, disallowNullValue: true)
  final String thumb;

  Photo({this.big, this.thumb});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  String get bigUrl => _appendingUrlWithHostIfNeeded(big);

  String get thumbUrl => _appendingUrlWithHostIfNeeded(thumb);

  String _appendingUrlWithHostIfNeeded(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    } else {
      return 'https://letswift.pl' + url;
    }
  }
}
