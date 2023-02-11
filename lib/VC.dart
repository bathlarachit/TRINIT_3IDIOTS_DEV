import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({
    Key? key,
    required this.callID,
    required this.userName,
    required this.userid,
  }) : super(key: key);
  final String callID;
  final String userid, userName;
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          540816634, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          '6d2486e04d76375e35535a063e964ed4feb4a4a88c8a8de540c9d2af48f4abae', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userid,
      userName: userName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
