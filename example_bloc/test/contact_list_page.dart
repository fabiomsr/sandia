import 'package:example_bloc/di/modules.dart';
import 'package:example_bloc/module/contact/list/contact_list_module.dart';
import 'package:example_bloc/module/contact/list/contact_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example_bloc/main.dart';
import 'package:sandia/sandia.dart';

import 'mock/test_module.dart';

void main() {
  testWidgets('Show contacts', (WidgetTester tester) async {

    await tester.pumpWidget(
      Injector(
        modules:[ TestDataModule(), UseCaseModule(), ContactListModule() ],
        child: MaterialApp(home: ContactsPage()),
      )
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    expect(find.byType(ContactList), findsOneWidget);
  });
}

