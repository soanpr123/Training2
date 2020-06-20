import 'package:flutter/services.dart';

class PayBloc {
  static const platform = const MethodChannel('samples.flutter.dev/battery');

  String batteryLevel;
  openMoMo(String money) async {
    try {
      var value = await platform.invokeMethod('oPenMoMo', {'money': double.parse(money.trim())});
      print(value);
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }
}

final payBloc = PayBloc();
