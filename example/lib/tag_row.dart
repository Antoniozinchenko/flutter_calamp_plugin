import 'package:flutter/material.dart';
import 'package:flutter_calamp/sci_tag.model.dart';

class TagRow extends StatelessWidget {
  final SCITag tag;
  TagRow({this.tag});
  @override
  Widget build(BuildContext context) {
    DateTime rxTime = DateTime.fromMillisecondsSinceEpoch(tag.rxTime);
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text('id: ${tag.id}'),
              Text('temperature: ${tag.temperature}'),
              Text('batteryVoltage: ${tag.batteryVoltage}'),
              Text('humidity: ${tag.humidity}'),
              Text('rssi: ${tag.rssi}'),
              Text('rxTime: ${rxTime.toIso8601String()}'),
              Text('sequenceNumber: ${tag.sequenceNumber}'),
            ],
          )),
    );
  }
}
