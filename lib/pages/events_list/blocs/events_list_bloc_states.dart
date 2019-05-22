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

abstract class EventsListBlocState {}

class EventsListBlocLoadingState extends EventsListBlocState {}

class EventsListBlocContentState extends EventsListBlocState {
  EventsListBlocContentState(
      {this.eventId,
      this.coverImageUrl,
      this.title,
      this.subtitle,
      this.placeName,
      this.placeStreet,
      this.date,
      this.time,
      this.cardStates});

  final int eventId;
  final String coverImageUrl;
  final String title;
  final String subtitle;
  final String placeName;
  final String placeStreet;
  final String date;
  final String time;
  final List<EventsListBlocCardContentState> cardStates;
}

class EventsListBlocCardContentState {
  EventsListBlocCardContentState(
      {this.eventId, this.thumbnailImageUrl, this.title, this.date});

  final int eventId;
  final String thumbnailImageUrl;
  final String title;
  final String date;
}

class EventsListBlocErrorState extends EventsListBlocState {
  EventsListBlocErrorState({this.error});

  final String error;
}
