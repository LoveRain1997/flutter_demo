import 'package:flutter/material.dart';

// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/people.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/teacher_section.dart';

/*
 void main() {
   runApp(new FriendlychatApp());
 }
*/

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

const String _name = "幸福黄金网友 提问 10:27：";
const String _nameTemp = "陈老师 10:27：";
/*
 class FriendlychatApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return new MaterialApp(
       title: "Friendlychat",
       theme: defaultTargetPlatform == TargetPlatform.iOS
           ? kIOSTheme
           : kDefaultTheme,
       home: new ChatScreen(),
     );
   }
 }*/

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController, this.isTeacher = false});
  final String text;
  final bool isTeacher;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(
                    child: new Text(isTeacher ? _nameTemp[0] : _name[0])),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(isTeacher ? _nameTemp : _name,
                        style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class SubTabTextLivePage extends StatefulWidget {

  SubTabTextLivePage({Key key}) : super(key: key);
  @override
  State createState() => new SubTabTextLivePageState();
}

class SubTabTextLivePageState extends State<SubTabTextLivePage>
    with TickerProviderStateMixin {

  final List<ChatMessage> _messages = <ChatMessage>[];

  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  void initState() {
    super.initState();

    //--------temp-start---------
    ChatMessage message = new ChatMessage(
      isTeacher: true,
      text: "受消息面影响，油价很有可能继续上走，建议回调做多为主",
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.add(message);
    });
    message.animationController.forward();

    //--------temp-end--------
  }

  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(hintText: "请您提问"),
              ),
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? new CupertinoButton(
                        child: new Text("Send"),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text)
                            : null,
                      )
                    : new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text)
                            : null,
                      )),
          ]),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))
              : null),
    );
  }

  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return new Container(
        child: new Column(children: <Widget>[
          new Container(
            padding: EdgeInsets.all(8.0),
            decoration: new BoxDecoration(color: themeData.backgroundColor),
            child: new Padding(
                padding: const EdgeInsets.all(0.0),
                child: new TeacherCardSection(<Teacher>[
                  Teacher(name: "老师1"),
                  Teacher(name: "老师2"),
                  Teacher(name: "老师3"),
                  Teacher(name: "老师4"),
                  Teacher(name: "老师5"),
                  Teacher(name: "老师6"),
                ])),
          ),
          new Flexible(
              child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            primary: true,
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          )),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ]),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? new BoxDecoration(
                border:
                    new Border(top: new BorderSide(color: Colors.grey[200])))
            : null); //new
  }
}
