import 'dart:convert';

import 'package:daca/models/place.dart';
import 'package:daca/public/api_endpoints.dart';
import 'package:daca/repositories/irepository.dart';
import 'package:daca/public/variables.dart';
import 'package:http/http.dart' as http;

/** 
 ** Repository responsible to fetch google places data
*/
class PlaceRepository implements IRepository {
  final String server = ApiEndpoint.googlePlacesServer;

  @override
  Future create(t) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future delete(t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List> getList() {
    // TODO: implement getList
    throw UnimplementedError();
  }

  Future getDetails(String id) async {
    List<Place> placeList = [];

    print(
        '$server${ApiEndpoint.googlePlacesDetailsEndpoint}?place_id=$id&fields=geometry&key=${DaCaVariables.googleApiKey}');

    final response = await http.get(
        '$server${ApiEndpoint.googlePlacesDetailsEndpoint}?place_id=$id&fields=geometry&key=${DaCaVariables.googleApiKey}');

    print(response.body);

    // if (response.statusCode == 200) {
    //   var decodedBody = jsonDecode(response.body);

    //   for (var place in decodedBody['results']) {
    //     placeList.add(Place.fromJson(place));
    //   }

    //   return placeList;
    // } else {
    //   throw Exception();
    // }
  }

  @override
  Future<List<Place>> getListById(String id) async {
    List<Place> placeList = [];

    final response = await http.get(
        '$server${ApiEndpoint.googlePlacesTextSearchEndpoint}?query=$id&key=${DaCaVariables.googleApiKey}');

    if (response.statusCode == 200) {
      var decodedBody = jsonDecode(response.body);

      for (var place in decodedBody['results']) {
        placeList.add(Place.fromJson(place));
      }

      return placeList;
    } else {
      throw Exception();
    }
  }

  @override
  Future update(t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
