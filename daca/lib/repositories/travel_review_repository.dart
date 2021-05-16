import 'dart:convert';
import 'package:daca/public/exceptions.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/models/travel_review.dart';
import 'package:daca/public/api_endpoints.dart';
import 'package:daca/public/variables.dart';
import 'irepository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class TravelReviewRepository implements IRepository<TravelReview> {
  final storage = new FlutterSecureStorage();
  final headers = {'Content-Type': 'application/json'};

  final String travelUrl =
      '${ApiEndpoint.apiServer}${ApiEndpoint.apiRoute}${ApiEndpoint.travelEndpoint}';

  @override
  Future<TravelReview> create(TravelReview review) async {
    String token = await storage.read(key: DaCaVariables.jwtToken);
    var decodedToken = JwtDecoder.decode(token);
    var body = review.toJson();
    body[DaCaVariables.userIdField] =
        decodedToken[DaCaVariables.userIdTokenField];

    print(json.encode(body));

    final response = await http.post(this.travelUrl,
        body: json.encode(body), headers: this.headers);

    if (response.statusCode == 201) {
      var decodedBody = jsonDecode(utf8.decode(response.bodyBytes));
      return TravelReview.fromJson(decodedBody);
    }
    if (response.statusCode == 400) {
      throw InvalidParametersException(DaCaStrings.invalidParametersError);
    }
    if (response.statusCode == 402) {
      throw InvalidParametersException(DaCaStrings.duplicateReview);
    }

    throw ConnectionException(DaCaStrings.connectionError);
  }

  @override
  Future<TravelReview> delete(TravelReview review) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<TravelReview> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<TravelReview>> getList() async {
    String token = await storage.read(key: DaCaVariables.jwtToken);
    var decodedToken = JwtDecoder.decode(token);
    String userId = decodedToken[DaCaVariables.userIdTokenField];

    String apiUrl = '${this.travelUrl}$userId/';
    print(apiUrl);

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      var decodedBody = jsonDecode(utf8.decode(response.bodyBytes));
      return (decodedBody as List)
          .map((e) => TravelReview.fromJson(e))
          .toList();
    }

    if (response.statusCode == 400) {
      throw InvalidParametersException(DaCaStrings.invalidParametersError);
    }

    throw ConnectionException(DaCaStrings.connectionError);
  }

  @override
  Future<List<TravelReview>> getListById(String id) {
    // TODO: implement getListById
    throw UnimplementedError();
  }

  @override
  Future<TravelReview> update(TravelReview review) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
