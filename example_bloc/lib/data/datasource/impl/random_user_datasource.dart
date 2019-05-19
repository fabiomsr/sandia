import 'dart:async';
import 'dart:convert';

import 'package:example_bloc/data/datasource/contact_datasource.dart';
import 'package:example_bloc/data/dto/contact_dto.dart';
import 'package:example_bloc/data/exception/fetch_data_exception.dart';
import 'package:dio/dio.dart';

class RandomUserDataSource implements ContactDataSource {
  static const _kRandomUserUrl = 'http://api.randomuser.me/?results=';

  Dio _dio;

  RandomUserDataSource(this._dio);

  Future<List<ContactDTO>> fetchContacts(int count) async {
    print("Request");
    try {
      final response = await _dio.get("$_kRandomUserUrl$count");
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300) {
        throw FetchDataException(
            "Error while getting contacts [StatusCode:$statusCode]");
      }

      final contactsContainer = jsonDecode(response.toString());
      final List contactItems = contactsContainer['results'];

      return contactItems
          .map((contactRaw) => ContactDTO.fromMap(contactRaw))
          .toList();
    } on DioError catch (e) {
      throw FetchDataException(
          "Error while getting contacts [Error:${e.message}]");
    } on Error catch (e) {
      throw FetchDataException(
          "Error while getting contacts [Error:${e.toString()}]");
    }
  }
}
