import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calamp/flutter_calamp.dart';

void main() => runApp(MyApp());

const username = 'someuser';
const password = 'somepass';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (BuildContext context) => FlutterCalamp(username, password),
      dispose: (BuildContext context, FlutterCalamp bloc) => bloc.dispoce(),
      child: MaterialApp(
        title: 'Flutter Demo',
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
        title: Text('Plugin test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<String>(
                stream: Provider.of<FlutterCalamp>(context).stream$,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Text(
                    snapshot.data ?? snapshot.error ?? 'Tap to start detecting',
                  );
                }),
            RaisedButton(
              onPressed: Provider.of<FlutterCalamp>(context).start,
              child: Text('Start Calamp'),
            ),
          ],
        ),
      ),
    );
  }
}
