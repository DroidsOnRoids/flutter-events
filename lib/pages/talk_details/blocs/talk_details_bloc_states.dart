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

class TalkDetailsBlocState {
  TalkDetailsBlocState(
      {this.speakerId,
      this.speakerImageUrl,
      this.speakerName,
      this.speakerJob,
      this.date,
      this.time,
      this.talkTitle,
      this.talkDescription});

  final int speakerId;
  final String speakerImageUrl;
  final String speakerName;
  final String speakerJob;
  final String date;
  final String time;
  final String talkTitle;
  final String talkDescription;
}
