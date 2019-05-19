class ContactDTO {
  final String fullName;
  final String gender;
  final String email;
  final String imageUrl;
  final LocationDTO location;
  final List<PhoneDTO> phones;

  const ContactDTO(
      {this.fullName,
      this.gender,
      this.email,
      this.imageUrl,
      this.location,
      this.phones});

  ContactDTO.fromMap(Map<String, dynamic> map)
      : fullName = "${map['name']['first']} ${map['name']['last']}",
        gender = map['gender'],
        email = map['email'],
        imageUrl = map['picture']['large'],
        location = LocationDTO.fromMap(map['location']),
        phones = <PhoneDTO>[
          new PhoneDTO(type: 'Home', number: map['phone']),
          new PhoneDTO(type: 'Mobile', number: map['cell'])
        ];
}

class LocationDTO {
  final String street;
  final String city;

  const LocationDTO({this.street, this.city});

  LocationDTO.fromMap(Map<String, dynamic> map)
      : street = map['street'],
        city = map['city'];
}

class PhoneDTO {
  final String type;
  final String number;

  const PhoneDTO({this.type, this.number});
}
