import 'package:example_bloc/data/usecase/contact_list_use_case.dart';
import 'package:example_bloc/module/contact/list/bloc/contact_list_bloc.dart';
import 'package:sandia/sandia.dart';

class ContactListModule implements Module {
  @override
  List<Provider> providers() => [
        Single(
            ContactListBloc, (r) => ContactListBloc(r.get(ContactListUseCase)))
      ];
}
