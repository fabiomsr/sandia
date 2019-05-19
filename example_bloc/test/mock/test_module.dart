import 'package:example_bloc/data/datasource/contact_datasource.dart';
import 'package:example_bloc/data/repository/contact_repository.dart';
import 'package:example_bloc/model/mapper/mapper.dart';
import 'package:sandia/sandia.dart';

import 'mock_datasource.dart';

class TestDataModule implements Module {
  @override
  List<Provider> providers() => [
        Factory(ContactDataSource, (r) => MockContactDataSource()),
        Factory(ContactMapper, (r) => ContactMapper()),
        Single(ContactRepository,
            (r) => ContactRepositoryImpl(r.get(ContactDataSource)))
      ];
}
