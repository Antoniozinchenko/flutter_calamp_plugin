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

// Get last detected tags:
List tags = calampPlugin.tags;

// Get stream of detected tags:
Stream tagsStream = calamp.stream$;

// Start detecting tags
calampPlugin.start();

// Stop detecting tags
calampPlugin.stop();

// Clear Listeners when dispose
calampPlugin.dispose()
```