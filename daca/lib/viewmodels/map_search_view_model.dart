import 'package:daca/models/place.dart';
import 'package:daca/repositories/place_repository.dart';
import 'package:flutter/cupertino.dart';

class MapSearchViewModel with ChangeNotifier {
  PlaceRepository repository = PlaceRepository();

  List<Place> searchPlaceList;
  String searchText;

  MapSearchViewModel() : this.searchText = "";

  void onSearchTextChange(String text) async {
    this.searchText = text;

    try {
      this.searchPlaceList = await repository.getListById(searchText);
    } on Exception catch (err) {
      print(err);
    }
  }
}
