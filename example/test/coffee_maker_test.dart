import 'package:example/components/coffe_maker.dart';
import 'package:example/components/heater.dart';
import 'package:example/components/pump.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandia/sandia.dart';

void main() {
  testWidgets('Make a new coffee', (WidgetTester tester) async {
    await tester.pumpWidget(
      Injector(
          modules: [TestModule()],
          child: MaterialApp(
            home: CoffeeMakerScreen(),
          )),
    );

    // Make Coffee
    await tester.tap(find.byType(FloatingActionButton));

    await tester.pump();

    expect(find.text('Coffee count: 1'), findsOneWidget);
  });
}

class TestModule implements Module {
  @override
  List<Provider> providers() {
    return [
      Single(Heater, (r) => ElectricHeater()),
      Single(Pump, (r) => Thermosiphon(r.get(Heater))),
      Single(CoffeeMaker, (r) => CoffeeMaker(r.get(Heater), r.get(Pump)))
    ];
  }
}
