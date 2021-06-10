import 'package:daca/models/travel_review.dart';
import 'package:daca/models/user.dart';
import 'package:daca/public/observer.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/public/variables.dart';
import 'package:daca/repositories/place_repository.dart';
import 'package:daca/repositories/travel_review_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter/foundation.dart';

class MapViewModel extends Observer with ChangeNotifier {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final GooglePlace googlePlace = GooglePlace(DaCaVariables.googleApiKey);
  final PlaceRepository placeRepository = PlaceRepository();
  final TravelReviewRepository travelReviewRepository =
      TravelReviewRepository();
  final double zoomAmount = 13.0;

  TravelReview selectedReview = null;
  List<TravelReview> travelReviewList = [];
  Set<Marker> markers = {};
  Position currentPosition;
  User user;

  Set<String> selectedReviewTypeList = {};
  bool isDisposed = false;
  bool foodChipState = true;
  bool travelChipState = true;
  bool lifeChipState = true;
  bool friendChipState = true;

  /* *
   * All chip state will become true after the constructor runs
   * since the onAllChipPress function reverses its value
   */
  bool allChipState = false;

  Function onCurrentPositionChangeCallback;
  Function onInfoWindowPressCallback;

  MapViewModel(this.user) {
    this.onAllChipPress();
  }

  void setOnCurrentPositionChange(Function callback) =>
      this.onCurrentPositionChangeCallback = callback;

  void setOnInfoWindowPress(Function callback) =>
      this.onInfoWindowPressCallback = callback;

  void setSelectedReview(TravelReview review) => this.selectedReview = review;

  List<TravelReview> getReviewList() => this
      .travelReviewList
      .where((review) => this.selectedReviewTypeList.contains(review.type))
      .toList();

  void onMapCreated() async {
    await this.fetchCurrentPosition();
    await this.fetchReviews();

    notifyListeners();
  }

  void onFoodChipPress() {
    this.foodChipState = !this.foodChipState;
    this.updateSelectedReviewTypeList(
        this.foodChipState, TravelReview.FOOD_TYPE);
    this.onChipStateChange();
  }

  void onTravelChipPress() {
    this.travelChipState = !this.travelChipState;
    this.updateSelectedReviewTypeList(
        this.travelChipState, TravelReview.TRAVEL_TYPE);
    this.onChipStateChange();
  }

  void onLifeChipPress() {
    this.lifeChipState = !this.lifeChipState;
    this.updateSelectedReviewTypeList(
        this.lifeChipState, TravelReview.LIFE_TYPE);
    this.onChipStateChange();
  }

  void onFriendChipPress() {
    this.friendChipState = !this.friendChipState;
    this.onChipStateChange();
  }

  void onAllChipPress() {
    this.allChipState = !this.allChipState;
    this.setChipStates();
    this.onChipStateChange();
  }

  /* *
   * Setting the state of the allChipState to false if 
   * at least one chip is false and updating the view
  */
  void onChipStateChange() {
    this.allChipState = (this.foodChipState &&
        this.travelChipState &&
        this.lifeChipState &&
        this.friendChipState);

    notifyListeners();
  }

  void setChipStates() {
    this.foodChipState = this.allChipState;
    this.travelChipState = this.allChipState;
    this.lifeChipState = this.allChipState;
    this.friendChipState = this.allChipState;
  }

  void updateSelectedReviewTypeList(bool isActive, String reviewType) {
    if (isActive) {
      this.selectedReviewTypeList.add(reviewType);
    } else {
      this.selectedReviewTypeList.remove(reviewType);
    }
  }

  Future<void> fetchReviews() async {
    this.travelReviewList =
        await this.travelReviewRepository.getListById(this.user.userId);
  }

  Future<void> fetchCurrentPosition() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then(
          (value) => {
            this.currentPosition = value,
            this.onCurrentPositionChangeCallback(this.currentPosition),
          },
        )
        .catchError(
          (err) => {
            print(err),
            Fluttertoast.showToast(
                msg: DaCaStrings.retrieveCurrentPositionError),
          },
        );
  }

  @override
  void update([review]) {
    this.travelReviewList.add(review);
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!this.isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    this.isDisposed = true;
    super.dispose();
  }
}
