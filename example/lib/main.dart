import 'package:flutter/material.dart';
import 'package:flutter_calamp_example/tags_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calamp/flutter_calamp.dart';

import 'package:flutter_calamp_example/footer.dart';

void main() => runApp(MyApp());

const username = 'USERNAME';
const password = 'USER_PASSWORD';
const appId = 'YOUR_APP_ID';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (BuildContext context) => FlutterCalamp(username, password, appId),
      dispose: (BuildContext context, FlutterCalamp bloc) => bloc.dispoce(),
      child: MaterialApp(
        title: 'Flutter CalAmp Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter CalAmp Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: TagsList()),
          Footer(),
        ],
      ),
    );
  }
}
