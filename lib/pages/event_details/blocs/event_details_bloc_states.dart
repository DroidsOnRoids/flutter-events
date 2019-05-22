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

import 'package:events/models/photo.dart';

abstract class EventDetailsBlocState {}

class EventDetailsBlocLoadingState extends EventDetailsBlocState {}

class EventDetailsBlocContentState extends EventDetailsBlocState {
  EventDetailsBlocContentState(
      {this.coverImageUrls,
      this.title,
      this.subtitle,
      this.placeName,
      this.placeStreet,
      this.date,
      this.time,
      this.photos,
      this.cardStates});

  final List<String> coverImageUrls;
  final String title;
  final String subtitle;
  final String placeName;
  final String placeStreet;
  final String date;
  final String time;
  final List<Photo> photos;
  final List<EventDetailsBlocCardContentState> cardStates;
}

class EventDetailsBlocErrorState extends EventDetailsBlocState {
  EventDetailsBlocErrorState({this.error});

  final String error;
}

class EventDetailsBlocCardContentState {
  EventDetailsBlocCardContentState(
      {this.speakerImageUrl,
      this.speakerName,
      this.speakerJob,
      this.talkTitle,
      this.talkDescription});

  final String speakerImageUrl;
  final String speakerName;
  final String speakerJob;
  final String talkTitle;
  final String talkDescription;
}
