import 'heater.dart';

abstract class Pump {
  void pump();
}

class Thermosiphon implements Pump {
  final Heater _heater;

  Thermosiphon(this._heater);

  @override
  void pump() {
    if (_heater.isHot) {
      print("=> => pumping => =>");
    }
  }
}