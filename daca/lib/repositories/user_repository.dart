import 'dart:convert';
import 'package:daca/public/strings.dart';
import 'package:daca/public/exceptions.dart';
import 'package:daca/models/user.dart';
import 'package:daca/public/api_endpoints.dart';
import 'package:daca/public/variables.dart';
import 'package:http/http.dart' as http;
import 'irepository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository implements IRepository<User> {
  final storage = new FlutterSecureStorage();

  final String loginUrl =
      '${ApiEndpoint.apiServer}${ApiEndpoint.apiRoute}${ApiEndpoint.loginEndpoint}';

  Future<User> getByIdAndPassword(String id, String password) async {
    var body = {
      DaCaVariables.userIdField: id,
      DaCaVariables.userPasswordField: password
    };

    final response = await http.post(this.loginUrl, body: body);

    if (response.statusCode == 200) {
      var decodedBody = jsonDecode(response.body);
      await storage.write(
          key: DaCaVariables.jwtToken,
          value: decodedBody[DaCaVariables.jwtTokenBackendField]);
      await storage.write(
          key: DaCaVariables.jwtRefreshToken,
          value: decodedBody[DaCaVariables.jwtRefreshTokenBackendField]);

      return User.fromJson(decodedBody[DaCaVariables.userBackendField]);
    }

    if (response.statusCode == 400) {
      throw InvalidCredentialsException(DaCaStrings.invalidCredentialsError);
    }

    throw ConnectionException(DaCaStrings.connectionError);
  }

  @override
  Future<User> create(User user) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<User> delete(User user) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<User> getById(String id) async {
    print('${this.loginUrl}$id');
    final response = await http.get('${this.loginUrl}$id');

    if (response.statusCode == 200) {
      var decodedBody = jsonDecode(response.body);
      print(decodedBody);
      // await storage.write(
      //     key: DaCaVariables.jwtToken,
      //     value: decodedBody[DaCaVariables.jwtTokenBackendField]);
      // await storage.write(
      //     key: DaCaVariables.jwtRefreshToken,
      //     value: decodedBody[DaCaVariables.jwtRefreshTokenBackendField]);

      return User.fromJson(decodedBody);
    }

    if (response.statusCode == 400) {
      throw InvalidCredentialsException(DaCaStrings.invalidCredentialsError);
    }

    throw ConnectionException(DaCaStrings.connectionError);
  }

  @override
  Future<List<User>> getList() {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<User> update(User user) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getListById(String id) {
    // TODO: implement getListById
    throw UnimplementedError();
  }
}
