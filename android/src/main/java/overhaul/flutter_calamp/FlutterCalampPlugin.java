package overhaul.flutter_calamp;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterCalampPlugin */
public class FlutterCalampPlugin implements MethodCallHandler {
  public static TagDetector tagDetector;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channelConsumer = new MethodChannel(registrar.messenger(), "com.overhaul.calamp_plugin/tagsConsumer");
    final MethodChannel channelProvider = new MethodChannel(registrar.messenger(), "com.overhaul.calamp_plugin/tagsProvider");
    channelConsumer.setMethodCallHandler(new FlutterCalampPlugin());
    tagDetector = new TagDetector(registrar.activeContext(), channelProvider);
  }

  @Override
  public void onMethodCall(MethodCall methodCall, Result result) {
    switch (methodCall.method) {
      case "start":
        tagDetector.start(methodCall.argument("userName").toString(), methodCall.argument("password").toString());
        result.success("Ok");
        break;
      case "stop":
        tagDetector.stop();
        result.success("Ok");
        break;
      default:
        result.notImplemented();
    }
  }
}
