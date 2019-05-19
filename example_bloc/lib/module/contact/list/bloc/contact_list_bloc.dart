import 'dart:async';

import 'package:example_bloc/data/usecase/contact_list_use_case.dart';
import 'package:example_bloc/model/contact.dart';

class ContactListBloc {
  // UseCases
  final ContactListUseCase _contactListUseCase;

  // Outputs
  Stream<List<Contact>> get contacts {
    return _contactListUseCase.stream;
  }

  ContactListBloc(this._contactListUseCase);
}
