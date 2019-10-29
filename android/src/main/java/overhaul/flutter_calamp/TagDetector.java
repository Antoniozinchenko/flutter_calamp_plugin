package overhaul.flutter_calamp;

import android.content.Context;
import android.util.Log;

import com.calamp.cms.sci.scitagandroidsdk.controller.SCIController;
import com.calamp.cms.sci.scitagandroidsdk.model.Credential;
import com.calamp.cms.sci.scitagandroidsdk.model.SCIException;
import com.calamp.cms.sci.scitagandroidsdk.model.SCITag;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;

import io.flutter.plugin.common.MethodChannel;

public class TagDetector {
    private final SCIController.OnSCITagsReceivedListener sciTagsCallbackListener = new SCIController.OnSCITagsReceivedListener() {
        @Override
        public void onSCITagsReceived(List<SCITag> list) {
            JSONArray jsonArray = new JSONArray();
            for (SCITag tag : list) {
                final JSONObject jsonTag = new JSONObject();
                try {
                    jsonTag.put("id", tag.getTagID());
                    jsonTag.put("temperature", tag.getTemperature());
                    jsonTag.put("batteryVoltage", tag.getBatteryVoltage());
                    jsonTag.put("humidity", tag.getHumidity());
                    jsonTag.put("rssi", tag.getRssi());
                    jsonTag.put("rxTime", tag.getRxTime());
                    jsonTag.put("sequenceNumber", tag.getSequenceNumber());
                    jsonArray.put(jsonTag);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
            Log.e("TagDetector", jsonArray.toString());
            methodChannel.invokeMethod("onScannedTags", jsonArray.toString());
        }
        @Override
        public void onErrorReceived(SCIException e) {
            methodChannel.invokeMethod("onError", e.getMessage());
            stop();
        }
    };
    private final SCIController.SCILoginCallback sciLoginCallback = new SCIController.SCILoginCallback() {
        @Override
        public void onLoginSuccess() {
            if (sciController != null) {
                isRunning = true;
                isLoggedIn = true;
                sciController.startSCITagService(sciTagsCallbackListener);
            }
        }
        @Override
        public void onLoginFailed(SCIException e) {
            methodChannel.invokeMethod("onError", e.getMessage());
            isRunning = false;
            isLoggedIn = false;
        }
    };
    private SCIController sciController;
    private Context appContext;
    private MethodChannel methodChannel;
    private boolean isRunning = false;
    private boolean isLoggedIn = false;

    TagDetector(Context context, MethodChannel flutterMethodChannel) {
        appContext = context;
        methodChannel = flutterMethodChannel;
    }
    private void init(String userName, String password) {
        final Credential credential = new Credential(userName, password, "d8b98aad-cc6e-4899-a86d-e2848eaf03b4");
        try {
            sciController = new SCIController.Builder()
                    .initialize(appContext)
                    .setCredentials(credential)
                    .setSCILoginCallback(sciLoginCallback)
                    .build();
        } catch(SCIException se) {
            se.printStackTrace();
            methodChannel.invokeMethod("onError", se.getMessage());
        }
    }
    public void start(String userName, String password) {
        if (!isRunning && isLoggedIn && sciController != null) {
            isRunning = true;
            sciController.startSCITagService(sciTagsCallbackListener);
        } else if (!isRunning) {
            init(userName, password);
        }
    }
    public void stop() {
        isRunning = false;
        if (sciController != null) {
            sciController.stopSCITagService();
            methodChannel.invokeMethod("onStopDetector", "Ok");
        }
    }

}