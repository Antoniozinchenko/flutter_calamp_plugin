# flutter_calamp

Flutter plugin for integration with CalAmp sdk

## Getting Started

Add dependency in **pubspec.yml**
```yml
dependencies:
  flutter_calamp:
    git:
      url: git://github.com/Antoniozinchenko/flutter_calamp_plugin.git
  provider: ^3.1.0+1
```
This plugin uses [rxDart](https://pub.dev/packages/rxdart) package for working with streams


## Usage

Plugin Provides **FlutterCalamp** Class:

```dart
import 'package:flutter_calamp/flutter_calamp.dart';


// Init FlutterCalamp plugin:
final calampPlugin = FlutterCalamp(username, password); 
```

## Reference
### FlutterCalamp 
|                  |           Type          |             Description            |
| :--------------- | :---------------------: |  :--------------------------------|
| tags             |  List\<SCITag>          | Field, that returns latest scanned list of tags |
| tagsStream       |  Stream<List\<SCITag>>  | Field, Stream that returns scanned list of tags |
| start            |  Future\<void>          | Method, for starting tag detection. |
| stop             |  Future\<void>          | Method, for stop tag detection. |

### SCITag 
|                  |           Type          |
| :--------------- | :---------------------- |
| id               |  String                 |
| temperature      |  double                 |
| batteryVoltage   |  double                 |
| humidity         |  double                 |
| rssi             |  int                    |
| rxTime           |  int                    |
| sequenceNumber   |  int                    |

