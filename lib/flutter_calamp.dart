import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class FlutterCalamp {
  static final channelProviderName = 'com.overhaul.calamp_plugin/tagsProvider';
  static final channelConsumerName = 'com.overhaul.calamp_plugin/tagsConsumer';
  final _consumerChannel = MethodChannel(channelConsumerName);
  final _providerChannel = MethodChannel(channelProviderName);
  final _tagSubject = BehaviorSubject<String>();
  final String username;
  final String password;

  FlutterCalamp(this.username, this.password) {
    _providerChannel.setMethodCallHandler(_didRecieveTags);
  }

  String get tags => _tagSubject.value;
  Observable<String> get stream$ => _tagSubject.stream;

  Future<void> start() async {
    try {
      await _consumerChannel.invokeMethod('start', <String, String>{
        'userName': username,
        'password': password,
      });
    } on PlatformException catch (e) {
      _tagSubject.addError(e.message);
    }
  }

  Future<void> stop() async {
    await _consumerChannel.invokeMethod('stop');
  }

  Future<void> _didRecieveTags(MethodCall call) async {
    print(call.arguments);
    switch (call.method) {
      case 'onScannedTags':
        {
          final String tags = call.arguments;
          _tagSubject.add(tags);
        }
        break;
      case 'onError':
        _tagSubject.addError(call.arguments);
    }
  }

  dispoce() {
    _tagSubject.close();
  }
}
