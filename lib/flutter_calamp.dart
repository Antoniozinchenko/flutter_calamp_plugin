import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_calamp/sci_tag.model.dart';
import 'package:flutter_calamp/utils.dart';

class FlutterCalamp {
  static final channelProviderName = 'com.overhaul.calamp_plugin/tagsProvider';
  static final channelConsumerName = 'com.overhaul.calamp_plugin/tagsConsumer';
  final _consumerChannel = MethodChannel(channelConsumerName);
  final _providerChannel = MethodChannel(channelProviderName);
  final _tagSubject = BehaviorSubject<List<SCITag>>();
  final _runningSubject = BehaviorSubject<bool>.seeded(false);
  final String username;
  final String password;
  final String appId;
  FlutterCalamp(this.username, this.password, this.appId) {
    _providerChannel.setMethodCallHandler(_didRecieveTags);
  }

  List<SCITag> get tags => _tagSubject.value;
  Stream<List<SCITag>> get stream$ => _tagSubject.stream;

  Observable<bool> get isRunning$ => _runningSubject.stream;

  Future<void> _invokeStart() async {
    try {
      await _consumerChannel.invokeMethod('start', <String, String>{
        'userName': username,
        'password': password,
        'appId': appId
      });
    } on PlatformException catch (e) {
      _runningSubject.add(false);
      _tagSubject.addError(e.message);
    }
  }

  Future<void> _didRecieveTags(MethodCall call) async {
    switch (call.method) {
      case 'onScannedTags':
        {
          final List jsonTags = jsonDecode(call.arguments);
          final List<SCITag> tags = [];
          for (var jsonTag in jsonTags) {
            tags.add(SCITag.fromJSON(jsonTag));
          }
          _tagSubject.add(tags);
        }
        break;
      case 'onError':
        _tagSubject.addError(call.arguments);
        _runningSubject.add(false);
    }
  }

  Future<void> start() async {
    if (!_runningSubject.value) {
      _runningSubject.add(true);
      final _isBluetoothOn = await PlatformUtils.checkBluetooth();
      final _isGpsOn = await PlatformUtils.checkGeolocation();
      if (_isBluetoothOn && _isGpsOn) {
        await _invokeStart();
      } else {
        _runningSubject.add(false);
      }
    }
  }

  Future<void> stop() async {
    if (_runningSubject.value) {
      _runningSubject.add(false);
      await _consumerChannel.invokeMethod('stop');
    }
  }

  dispoce() {
    _tagSubject.close();
    _runningSubject.close();
  }
}
