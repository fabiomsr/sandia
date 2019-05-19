import 'package:example_bloc/data/dto/contact_dto.dart';

abstract class ContactDataSource {
  Future<List<ContactDTO>> fetchContacts(int count);
}
