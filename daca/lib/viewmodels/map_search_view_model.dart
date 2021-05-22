import 'package:daca/models/place.dart';
import 'package:daca/models/travel_review.dart';
import 'package:daca/models/travel_review_image.dart';
import 'package:daca/public/exceptions.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/public/subject.dart';
import 'package:daca/repositories/place_repository.dart';
import 'package:daca/repositories/travel_review_image_repository.dart';
import 'package:daca/repositories/travel_review_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class MapSearchViewModel extends Subject with ChangeNotifier {
  PlaceRepository placeRepository;
  TravelReviewRepository travelReviewRepository;
  TravelReviewImageRepository travelReviewImageRepository;
  List<Place> searchPlaceList;
  Place selectedPlace;
  TravelReview travelReview;
  String searchText;
  String imagePath;

  MapSearchViewModel() {
    this.setDefaultState();
  }

  void setSelectedPlace(Place place) {
    this.selectedPlace = place;
    this.travelReview.setPlace(Place(placeId: this.selectedPlace.placeId));
    this.travelReview.setTitle(this.selectedPlace.name);
    this.imagePath = null;
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
    this.travelReviewImageRepository = TravelReviewImageRepository();
    this.travelReview = TravelReview.defaultReview();
    this.searchText = "";
    this.selectedPlace = null;
    this.imagePath = null;
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

  Future<void> onSelectImagePress() async {
    PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);

    if (file != null) {
      this.imagePath = file.path;
      notifyListeners();
    }
  }

  Future<void> onSubmitReviewPress() async {
    try {
      TravelReview review =
          await this.travelReviewRepository.create(this.travelReview);

      if (this.imagePath != null) {
        review.addImage(
          await this.travelReviewImageRepository.create(
                TravelReviewImage(
                  id: review.id,
                  imageUrl: this.imagePath,
                ),
              ),
        );
      }

      for (var observer in this.observers) {
        observer.update(review);
      }

      Fluttertoast.showToast(msg: DaCaStrings.reviewCreatedSuccess);
    } on InvalidParametersException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    } on ConnectionException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    }

    this.setDefaultState();
  }
}
