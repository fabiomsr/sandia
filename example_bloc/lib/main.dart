import 'package:example_bloc/di/modules.dart';
import 'package:example_bloc/module/contact/list/contact_list_module.dart';
import 'package:example_bloc/module/contact/list/contact_list_page.dart';
import 'package:flutter/material.dart';
import 'package:sandia/sandia.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Injector(
        modules: [NetworkModule(), DataModule(), UseCaseModule()],
        child: MaterialApp(
            title: 'Sandia Bloc Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              "/": (context) {
                return Injector(
                  modules: [ContactListModule()],
                  child: Container(child: ContactsPage()),
                );
              },
            }));
  }
}
