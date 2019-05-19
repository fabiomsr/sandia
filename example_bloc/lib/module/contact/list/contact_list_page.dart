
import 'package:dio/dio.dart';
import 'package:example_bloc/data/datasource/impl/random_user_datasource.dart';
import 'package:example_bloc/data/repository/contact_repository.dart';
import 'package:example_bloc/data/usecase/contact_list_use_case.dart';
import 'package:example_bloc/model/contact.dart';
import 'package:example_bloc/model/mapper/mapper.dart';
import 'package:example_bloc/module/contact/detail/contact_detail_page.dart';
import 'package:example_bloc/module/contact/list/bloc/contact_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sandia/sandia.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  ContactListBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Injector.of(context).resolve(context, ContactListBloc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        body: StreamBuilder(
          stream: _bloc.contacts,
          builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
            if (snapshot.hasData) {
              return _ContactList(
                  contacts: snapshot.data,
                  onContactTapped: (contact) => _showContactPage(context, contact));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  void _showContactPage(BuildContext context, Contact contact) {
    Navigator.push(
        context,
        new MaterialPageRoute<Null>(
            settings: const RouteSettings(name: ContactPage.routeName),
            builder: (BuildContext context) => new ContactPage(contact)));
  }
}

///
///   Contact List
///

class _ContactList extends StatelessWidget {
  final List<Contact> contacts;
  final Function(Contact) onContactTapped;

  _ContactList({@required this.contacts, @required this.onContactTapped});

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _buildContactList(contacts));
  }

  List<_ContactListItem> _buildContactList(List<Contact> contacts) {
    return contacts
        .map((contact) => new _ContactListItem(
            contact: contact,
            onTap: () => onContactTapped(contact)))
        .toList();
  }
}

///
///   Contact List Item
///

class _ContactListItem extends ListTile {
  _ContactListItem(
      {@required Contact contact, @required GestureTapCallback onTap})
      : super(
            title: Text(contact.fullName),
            subtitle: Text(contact.email),
            leading: CircleAvatar(child: Text(contact.fullName[0])),
            onTap: onTap);
}
