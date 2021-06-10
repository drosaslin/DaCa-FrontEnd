import 'package:daca/models/place.dart';
import 'package:daca/models/travel_review.dart';
import 'package:daca/models/travel_review_image.dart';
import 'package:daca/models/user.dart';
import 'package:daca/public/exceptions.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/public/subject.dart';
import 'package:daca/repositories/place_repository.dart';
import 'package:daca/repositories/travel_review_image_repository.dart';
import 'package:daca/repositories/travel_review_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class PlaceSearchViewModel extends Subject with ChangeNotifier {
  final PlaceRepository placeRepository = PlaceRepository();
  final TravelReviewRepository travelReviewRepository =
      TravelReviewRepository();
  final TravelReviewImageRepository travelReviewImageRepository =
      TravelReviewImageRepository();

  List<Place> searchPlaceList;
  Place selectedPlace;
  TravelReview travelReview;
  User user;
  String title;
  String review;
  String type;
  double rating;
  String searchText;
  String imagePath;

  PlaceSearchViewModel(this.user) {
    this.setDefaultState();
    this.user = user;
  }

  void onPlaceSelected(Place place) {
    this.selectedPlace = place;
    this.title = this.selectedPlace.name;
    this.imagePath = null;
    notifyListeners();
  }

  void onTitleChange(String text) {
    this.title = text;
  }

  void onReviewChange(String text) {
    this.review = text;
  }

  void onRatingChange(double rating) {
    this.rating = rating;
  }

  void setDefaultState() {
    this.searchText = "";
    this.title = "";
    this.review = "";
    this.rating = 2.5;
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
    TravelReview reviewToCreate = TravelReview(
      title: this.title,
      review: this.review,
      rating: this.rating,
      type: this.type,
      date: DateTime.now(),
      place: this.selectedPlace,
    );

    try {
      TravelReview review = await this
          .travelReviewRepository
          .createById(reviewToCreate, this.user.userId);

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
