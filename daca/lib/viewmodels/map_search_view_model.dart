import 'package:daca/models/place.dart';
import 'package:daca/models/travel_review.dart';
import 'package:daca/models/user.dart';
import 'package:daca/public/exceptions.dart';
import 'package:daca/repositories/place_repository.dart';
import 'package:daca/repositories/travel_review_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MapSearchViewModel with ChangeNotifier {
  PlaceRepository placeRepository;
  TravelReviewRepository travelReviewRepository;
  List<Place> searchPlaceList;
  Place selectedPlace;
  TravelReview travelReview;
  String searchText;

  MapSearchViewModel() {
    this.placeRepository = PlaceRepository();
    this.travelReviewRepository = TravelReviewRepository();
    this.travelReview = TravelReview.defaultReview();
    this.searchText = "";
    this.selectedPlace = null;
    this.searchPlaceList = [];
  }

  void setSelectedPlace(Place place) {
    this.selectedPlace = place;
    this.travelReview.setPlaceId(this.selectedPlace.placeId);
    this.travelReview.setTitle(this.selectedPlace.name);
    notifyListeners();
  }

  void onTitleChange(String text) {
    this.travelReview.setTitle(text);
  }

  void onReviewChange(String text) {
    this.travelReview.setReview(text);
  }

  void onRatingChange(double rating) {
    this.travelReview.setRating(rating);
  }

  void onSearchTextChange(String text) async {
    this.searchText = text;

    try {
      this.searchPlaceList = await placeRepository.getListById(searchText);
      notifyListeners();
    } on Exception catch (err) {
      print(err);
    }
  }

  Future<void> onSubmitReviewPress() async {
    try {
      await this.travelReviewRepository.create(this.travelReview);
      Fluttertoast.showToast(msg: 'Review Created!');
    } on InvalidParametersException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    } on ConnectionException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    }
  }
}
