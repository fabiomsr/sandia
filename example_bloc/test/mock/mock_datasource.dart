import 'package:example_bloc/data/datasource/contact_datasource.dart';
import 'package:example_bloc/data/dto/contact_dto.dart';

class MockContactDataSource implements ContactDataSource {
  @override
  Future<List<ContactDTO>> fetchContacts(int count) async {
    return <ContactDTO>[
      ContactDTO(
          fullName: 'Romain Hoogmoed',
          email: 'romain.hoogmoed@example.com',
          phones: [ PhoneDTO(type: "t", number: '999-999-555')],
          location: LocationDTO(city: 'London', street: 'Oxford Street')),

    ];
  }
}
