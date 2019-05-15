import 'components/coffe_maker.dart';
import 'components/heater.dart';
import 'components/pump.dart';
import 'package:flutter/material.dart';
import 'package:sandia/sandia.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(
        providers: [
          Single(Heater, (r) => ElectricHeater()),
          Single(Pump, (r) => Thermosiphon(r.get(Heater))),
        ],
        child: MaterialApp(
          title: 'Sandia Example',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Injector(
            providers: [
              Single(
                  CoffeeMaker, (r) => CoffeeMaker(r.get(Heater), r.get(Pump)))
            ],
            child: CoffeeMakerScreen(),
          ),
        ));
  }
}

class CoffeeMakerScreen extends StatefulWidget {
  CoffeeMakerScreen({Key key}) : super(key: key);

  @override
  _CoffeeMakerScreenState createState() => _CoffeeMakerScreenState();
}

class _CoffeeMakerScreenState extends State<CoffeeMakerScreen> {
  CoffeeMaker _coffeeMaker;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _coffeeMaker = Injector.of(context).resolve(context, CoffeeMaker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coffe Maker UI"),
      ),
      body: Center(
        child: Text(
          'Make coffe:',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _coffeeMaker.brew(),
        tooltip: 'Make coffe',
        child: Icon(Icons.free_breakfast),
      ),
    );
  }
}
