import 'package:daca/models/place.dart';
import 'package:daca/models/travel_review.dart';
import 'package:daca/public/exceptions.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/public/subject.dart';
import 'package:daca/repositories/place_repository.dart';
import 'package:daca/repositories/travel_review_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MapSearchViewModel extends Subject with ChangeNotifier {
  PlaceRepository placeRepository;
  TravelReviewRepository travelReviewRepository;
  List<Place> searchPlaceList;
  Place selectedPlace;
  TravelReview travelReview;
  String searchText;

  MapSearchViewModel() {
    this.setDefaultState();
  }

  void setSelectedPlace(Place place) {
    this.selectedPlace = place;
    this.travelReview.setPlace(Place(placeId: this.selectedPlace.placeId));
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

  void setDefaultState() {
    this.placeRepository = PlaceRepository();
    this.travelReviewRepository = TravelReviewRepository();
    this.travelReview = TravelReview.defaultReview();
    this.searchText = "";
    this.selectedPlace = null;
    this.searchPlaceList = [];
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
      TravelReview review =
          await this.travelReviewRepository.create(this.travelReview);
      Fluttertoast.showToast(msg: DaCaStrings.reviewCreatedSuccess);

      for (var observer in this.observers) {
        observer.update(review);
      }

      print(review.toJson());
    } on InvalidParametersException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    } on ConnectionException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    }

    this.setDefaultState();
  }
}
