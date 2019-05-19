class Contact {
  final String fullName;
  final String gender;
  final String email;
  final String imageUrl;
  final Location location;
  final List<Phone> phones;

  const Contact(
      {this.fullName,
      this.gender,
      this.email,
      this.imageUrl,
      this.location,
      this.phones});
}

class Location {
  final String street;
  final String city;

  const Location({this.street, this.city});
}

class Phone {
  final String type;
  final String number;

  const Phone({this.type, this.number});
}
