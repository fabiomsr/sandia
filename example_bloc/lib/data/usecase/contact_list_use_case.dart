


import 'package:example_bloc/data/repository/contact_repository.dart';
import 'package:example_bloc/model/contact.dart';
import 'package:example_bloc/model/mapper/mapper.dart';

class ContactListUseCase {

  final ContactRepository _repository;
  final ContactMapper _mapper;

  ContactListUseCase(this._repository, this._mapper);

  Stream<List<Contact>> get stream => _repository.contacts
          .map((entities) => entities.map(_mapper.map).toList());

}