import 'dart:io';
import 'package:daca/models/place.dart';
import 'package:daca/models/travel_review.dart';
import 'package:daca/public/exceptions.dart';
import 'package:daca/repositories/place_repository.dart';
import 'package:daca/repositories/travel_review_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class MapSearchViewModel with ChangeNotifier {
  PlaceRepository placeRepository;
  TravelReviewRepository travelReviewRepository;
  List<Place> searchPlaceList;
  Place selectedPlace;
  TravelReview travelReview;
  String searchText;
  File travelReviewImage;

  MapSearchViewModel() {
    this.placeRepository = PlaceRepository();
    this.travelReviewRepository = TravelReviewRepository();
    this.travelReview = TravelReview.defaultReview();
    this.searchText = "";
    this.selectedPlace = null;
    this.travelReviewImage = null;
    this.searchPlaceList = [];
  }

  void setSelectedPlace(Place place) {
    this.selectedPlace = place;
    this.travelReview.setPlace(Place(placeId: this.selectedPlace.placeId));
    this.travelReview.setTitle(this.selectedPlace.name);
    this.travelReviewImage = null;
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

  void onTravelReviewImageChange(File image) {
    this.travelReviewImage = image;
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

  Future<void> onUploadImagePress() async {
    PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);

    if (file != null) {
      this.travelReviewImage = File(file.path);
      notifyListeners();
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
