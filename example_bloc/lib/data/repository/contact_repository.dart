import 'package:example_bloc/data/datasource/contact_datasource.dart';
import 'package:example_bloc/data/dto/contact_dto.dart';
import 'package:rxdart/subjects.dart';

abstract class ContactRepository {
  Stream<List<ContactDTO>> get contacts;
}

class ContactRepositoryImpl implements ContactRepository {
  final ContactDataSource _dataSource;
  final BehaviorSubject<List<ContactDTO>> _subject;
  bool _loaded = false;

  ContactRepositoryImpl(this._dataSource)
      : _subject = BehaviorSubject<List<ContactDTO>>();

  Stream<List<ContactDTO>> get contacts {
    if (!_loaded) {
      _loadContacts(15);
    }

    return _subject.stream;
  }

  void _loadContacts(int count) {
    _loaded = true;
    _dataSource.fetchContacts(count).then((entities) {
      final contacts = List<ContactDTO>.unmodifiable(
        []..addAll(_subject.value ?? [])..addAll(entities),
      );
      _subject.add(contacts);
    }).catchError((e) {
      _loaded = false;
      _subject.addError(e);
    });
  }
}
