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

import 'package:flutter/cupertino.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/widgets/app_button.dart';
import 'package:events/widgets/navigation_bar.dart';
import 'package:events/widgets/tap_detector.dart';

import 'blocs/contact_bloc.dart';
import 'contact_topic_modal.dart';

class ContactPage extends StatefulWidget {
  final ContactBlocType _bloc;

  ContactPage({@required ContactBlocType bloc})
      : assert(bloc != null),
        _bloc = bloc;

  ContactPage.build() : this(bloc: ContactBlocType.build());

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactBlocType get _bloc => widget._bloc;

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  String _topicSelectorText(String text) {
    final prefix = 'I want to';

    if (text != null) {
      return prefix + ' ' + text.toLowerCase();
    } else {
      return prefix + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: NavigationBar(title: 'CONTACT', hasBorder: true),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              _buildTopicSelector(),
              SizedBox(height: 32.0),
              _buildTextFieldsRow(),
              SizedBox(height: 32.0),
              CupertinoTextField(
                  padding:
                      EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                  placeholder: 'Message',
                  textInputAction: TextInputAction.next,
                  placeholderStyle: null,
                  maxLines: 8,
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).white,
                    border: Border.all(color: AppColors.of(context).lightGray),
                    borderRadius: BorderRadius.circular(5.0),
                  )),
              SizedBox(height: 32.0),
              AppButton(
                  text: 'SEND', style: AppButtonStyle.filled, height: 56.0)
            ],
          ),
        ));
  }

  Widget _buildTopicSelector() {
    return TapDetector(
        onTap: () {
          showCupertinoModalPopup(
              context: context,
              builder: (context) =>
                  ContactTopicModal(children: _bloc.topics)).then((result) {
            _bloc.onTopicSelected(index: result);
          });
        },
        childBuilder: (isPressed) => AnimatedContainer(
              duration: Duration(milliseconds: 100),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: isPressed
                      ? AppColors.of(context).lightGray.withAlpha(128)
                      : null,
                  border: Border.all(color: AppColors.of(context).lightGray),
                  borderRadius: BorderRadius.circular(6.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StreamBuilder(
                      stream: _bloc.currentTopicStream,
                      builder: (context, AsyncSnapshot<String> snapshot) =>
                          Text(_topicSelectorText(snapshot.data),
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.67))),
                  Image.asset('images/indicator.png')
                ],
              ),
            ));
  }

  Widget _buildTextFieldsRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CupertinoTextField(
                padding: EdgeInsets.all(16.0),
                placeholder: 'Your name',
                textInputAction: TextInputAction.next,
                placeholderStyle: null,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.of(context).white,
                  border: Border.all(color: AppColors.of(context).lightGray),
                  borderRadius: BorderRadius.circular(5.0),
                )),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CupertinoTextField(
                padding: EdgeInsets.all(16.0),
                placeholder: 'Your email',
                textInputAction: TextInputAction.next,
                placeholderStyle: null,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.of(context).white,
                  border: Border.all(color: AppColors.of(context).lightGray),
                  borderRadius: BorderRadius.circular(5.0),
                )),
          ),
        ),
      ],
    );
  }
}
