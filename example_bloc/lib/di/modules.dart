import 'package:dio/dio.dart';
import 'package:example_bloc/data/datasource/contact_datasource.dart';
import 'package:example_bloc/data/datasource/impl/random_user_datasource.dart';
import 'package:example_bloc/data/repository/contact_repository.dart';
import 'package:example_bloc/data/usecase/contact_list_use_case.dart';
import 'package:example_bloc/model/mapper/mapper.dart';
import 'package:sandia/sandia.dart';

class NetworkModule implements Module {
  @override
  List<Provider> providers() => [Single(Dio, (r) => Dio())];
}

class DataModule implements Module {
  @override
  List<Provider> providers() => [
        Factory(ContactDataSource, (r) => RandomUserDataSource(r.get(Dio))),
        Factory(ContactMapper, (r) => ContactMapper()),
        Single(ContactRepository,
            (r) => ContactRepositoryImpl(r.get(ContactDataSource)))
      ];
}

class UseCaseModule implements Module {
  @override
  List<Provider> providers() => [
        Factory(
            ContactListUseCase,
            (r) => ContactListUseCase(
                r.get(ContactRepository), r.get(ContactMapper)))
      ];
}
