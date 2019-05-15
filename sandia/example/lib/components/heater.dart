abstract class Heater {
  get isHot;

  void on();

  void off();
}

class ElectricHeater implements Heater {
  bool _heating;

  @override
  get isHot => _heating;

  @override
  void on() {
    print("~ ~ ~ heating ~ ~ ~");
    _heating = true;
  }

  void off() {
    _heating = false;
  }
}
