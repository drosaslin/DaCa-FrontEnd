import 'dart:convert';
import 'dart:io';
import 'package:daca/public/exceptions.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/models/travel_review_image.dart';
import 'package:daca/public/api_endpoints.dart';
import 'package:daca/public/variables.dart';
import 'irepository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class TravelReviewImageRepository implements IRepository<TravelReviewImage> {
  final String travelImageUrl =
      '${ApiEndpoint.apiServer}${ApiEndpoint.apiRoute}${ApiEndpoint.travelImageEndpoint}';

  @override
  Future<TravelReviewImage> create(TravelReviewImage reviewImage) async {
    var request = new http.MultipartRequest(
        DaCaVariables.postMethod, Uri.parse(this.travelImageUrl));
    request.fields[DaCaVariables.imageReviewIdField] =
        reviewImage.id.toString();
    request.files.add(
      await http.MultipartFile.fromPath(
        DaCaVariables.imageField,
        reviewImage.imageUrl,
        contentType: MediaType(
          DaCaVariables.imageMediaType,
          DaCaVariables.imageFormat,
        ),
      ),
    );

    final streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      var decodedBody = jsonDecode(response.body);
      return TravelReviewImage.fromJson(decodedBody);
    }
    if (response.statusCode == 400) {
      throw InvalidParametersException(DaCaStrings.invalidParametersError);
    }

    throw ConnectionException(DaCaStrings.connectionError);
  }

  @override
  Future<TravelReviewImage> delete(TravelReviewImage t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<TravelReviewImage> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<TravelReviewImage>> getList() {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<List<TravelReviewImage>> getListById(String id) {
    // TODO: implement getListById
    throw UnimplementedError();
  }

  @override
  Future<TravelReviewImage> update(TravelReviewImage t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
