import 'package:example_bloc/data/dto/contact_dto.dart';
import 'package:example_bloc/model/contact.dart';

abstract class Mapper<DTO, Model> {
  Model map(DTO dto);
}

class ContactMapper implements Mapper<ContactDTO, Contact> {
  final locationMapper = LocationMapper();
  final phoneMapper = PhoneMapper();

  @override
  Contact map(ContactDTO dto) {
    return Contact(
        fullName: dto.fullName,
        gender: dto.gender,
        email: dto.email,
        imageUrl: dto.imageUrl,
        location: locationMapper.map(dto.location),
        phones: dto.phones.map(phoneMapper.map).toList());
  }
}

class LocationMapper implements Mapper<LocationDTO, Location> {
  @override
  Location map(LocationDTO dto) {
    return Location(street: dto.street, city: dto.city);
  }
}

class PhoneMapper implements Mapper<PhoneDTO, Phone> {
  @override
  Phone map(PhoneDTO dto) {
    return Phone(type: dto.type, number: dto.number);
  }
}
