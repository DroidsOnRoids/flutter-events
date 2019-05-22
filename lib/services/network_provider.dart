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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:events/models/event.dart';
import 'package:events/models/speaker.dart';

abstract class NetworkProviderType {
  factory NetworkProviderType.build() => NetworkProvider(client: Client());

  Future<List<Event>> fetchEventsList();

  Future<Event> fetchEvent({int id});

  Future<List<Speaker>> fetchSpeakersList({bool recent});

  Future<Speaker> fetchSpeaker({int id});
}

class NetworkProvider implements NetworkProviderType {
  static const _BASE_PATH = 'https://letswift.pl/api/v1/';
  static const _TIMEOUT = 5;

  final Client _client;

  NetworkProvider({@required Client client})
      : assert(client != null),
        _client = client;

  @override
  Future<List<Event>> fetchEventsList() async {
    return _get(path: 'events', parse: _eventsListFromBody);
  }

  @override
  Future<Event> fetchEvent({int id}) async {
    return _get(path: 'events/' + id.toString(), parse: _eventFromBody);
  }

  @override
  Future<List<Speaker>> fetchSpeakersList({bool recent}) async {
    return _get(
        path: recent ? 'speakers/recent' : 'speakers',
        parse: _speakersListFromBody);
  }

  @override
  Future<Speaker> fetchSpeaker({int id}) async {
    return _get(path: 'speakers/' + id.toString(), parse: _speakerFromBody);
  }

  Future<T> _get<T>({String path, T parse(String _)}) async {
    final response = await _client.get(_BASE_PATH + path, headers: {
      HttpHeaders.acceptHeader: 'application/json'
    }).timeout(Duration(seconds: _TIMEOUT));

    final parsed = await compute(parse, response.body);

    return parsed;
  }

  static List<Event> _eventsListFromBody(String response) {
    final jsonResponse = jsonDecode(response) as Map<String, dynamic>;
    final events = jsonResponse['events'] as List;

    return events.map((eventJson) => Event.fromJson(eventJson)).toList();
  }

  static Event _eventFromBody(String response) {
    final jsonResponse = jsonDecode(response) as Map<String, dynamic>;
    final event = Event.fromJson(jsonResponse['event']);

    return event;
  }

  static List<Speaker> _speakersListFromBody(String response) {
    final jsonResponse = jsonDecode(response) as Map<String, dynamic>;
    final speakers = jsonResponse['speakers'] as List;

    return speakers
        .map((speakerJson) => Speaker.fromJson(speakerJson))
        .toList();
  }

  static Speaker _speakerFromBody(String response) {
    final jsonResponse = jsonDecode(response) as Map<String, dynamic>;
    final speaker = Speaker.fromJson(jsonResponse['speaker']);

    return speaker;
  }
}
