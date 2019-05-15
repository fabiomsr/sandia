import 'heater.dart';
import 'pump.dart';

class CoffeeMaker {
  final Heater _heater;
  final Pump _pump;

  CoffeeMaker(this._heater, this._pump);

  void brew() {
    _heater.on();
    _pump.pump();
    print(" [_]P coffee! [_]P ");
    _heater.off();
  }
}