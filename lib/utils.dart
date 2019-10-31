import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:location/location.dart';

class PlatformUtils {
  static Future<bool> checkBluetooth() async {
    final state = await FlutterBluetoothSerial.instance.state;
    if (state == BluetoothState.STATE_ON) {
      return true;
    } else {
      return await FlutterBluetoothSerial.instance.requestEnable(); 
    }
  }
  static Future<bool> checkGeolocation() async {
    var location = new Location();
    return await location.requestPermission();
  }
}