import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calamp/flutter_calamp.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<FlutterCalamp>(context).isRunning$,
        builder: (context, AsyncSnapshot snapshot) {
          final isRunning = snapshot.data == true;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                onPressed: isRunning
                    ? null
                    : Provider.of<FlutterCalamp>(context).start,
                child: Text('Start Calamp'),
              ),
              RaisedButton(
                onPressed:
                    isRunning ? Provider.of<FlutterCalamp>(context).stop : null,
                child: Text('Stop Calamp'),
              ),
            ],
          );
        });
  }
}
