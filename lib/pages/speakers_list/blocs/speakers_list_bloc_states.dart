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

abstract class SpeakersListBlocState {}

class SpeakersListBlocLoadingState extends SpeakersListBlocState {}

class SpeakersListBlocContentState extends SpeakersListBlocState {
  SpeakersListBlocContentState({this.recentSpeakers, this.speakersList});

  final List<SpeakersListBlocCardContentState> recentSpeakers;
  final List<SpeakersListBlocCardContentState> speakersList;
}

class SpeakersListBlocCardContentState {
  SpeakersListBlocCardContentState(
      {this.speakerId, this.thumbnailImageUrl, this.name, this.job});

  final int speakerId;
  final String thumbnailImageUrl;
  final String name;
  final String job;
}

class SpeakersListBlocErrorState extends SpeakersListBlocState {
  SpeakersListBlocErrorState({this.error});

  final String error;
}
