#import "FlutterCalampPlugin.h"
#import <flutter_calamp/flutter_calamp-Swift.h>

@implementation FlutterCalampPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterCalampPlugin registerWithRegistrar:registrar];
}
@end
