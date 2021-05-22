import 'package:daca/models/travel_review.dart';
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

  bool isDisposed = false;
  bool foodChipState = true;
  bool travelChipState = true;
  bool lifeChipState = true;
  bool friendChipState = true;
  bool allChipState = true;
  TravelReview selectedReview = null;
  Set<Marker> markers = {};
  List<TravelReview> travelReviewList = [];
  Position currentPosition;

  Function onCurrentPositionChangeCallback;
  Function onInfoWindowPressCallback;

  TravelMapViewModel() {
    this.allChipState = true;
    this.onAllChipPress();
  }

  void setOnCurrentPositionChange(Function callback) =>
      this.onCurrentPositionChangeCallback = callback;

  void setOnInfoWindowPress(Function callback) =>
      this.onInfoWindowPressCallback = callback;

  void setSelectedReview(TravelReview review) {
    this.selectedReview = review;
  }

  void onMapCreated() {
    this.getCurrentPosition();
    this.getReviews();

    notifyListeners();
  }

  void onFoodChipPress() {
    this.foodChipState = !this.foodChipState;
    onChipStateChange();
  }

  void onTravelChipPress() {
    this.travelChipState = !this.travelChipState;
    onChipStateChange();
  }

  void onLifeChipPress() {
    this.lifeChipState = !this.lifeChipState;
    onChipStateChange();
  }

  void onFriendChipPress() {
    this.friendChipState = !this.friendChipState;
    onChipStateChange();
  }

  void onAllChipPress() {
    this.allChipState = !this.allChipState;
    setChipStates(this.allChipState);
    onChipStateChange();
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

  void setChipStates(bool state) {
    this.foodChipState = state;
    this.travelChipState = state;
    this.lifeChipState = state;
    this.friendChipState = state;
  }

  Future<void> getReviews() async {
    this.travelReviewList = await this.travelReviewRepository.getList();
  }

  Future<void> getCurrentPosition() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) => {
              this.currentPosition = value,
              this.onCurrentPositionChangeCallback(this.currentPosition),
            })
        .catchError((err) => {
              print(err),
              Fluttertoast.showToast(
                  msg: DaCaStrings.retrieveCurrentPositionError),
            });
  }

  @override
  void update([review]) {
    print('updating...');
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
