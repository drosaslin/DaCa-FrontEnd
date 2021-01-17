import 'package:daca/public/strings.dart';
import 'package:daca/public/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter/foundation.dart';

class TravelMapViewModel with ChangeNotifier {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final GooglePlace googlePlace = GooglePlace(DaCaVariables.googleApiKey);
  final double zoomAmount = 13.0;

  bool foodChipState = true;
  bool travelChipState = true;
  bool lifeChipState = true;
  bool friendChipState = true;
  bool allChipState = true;
  Position currentPosition;

  TravelMapViewModel();

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
   * -at least one chip is false and updating the view
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

  Future<void> getCurrentPosition(GoogleMapController controller) async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) => {
              this.currentPosition = value,
              notifyListeners(),
              // updateMapPosition(controller, this.currentPosition),
            })
        .catchError((err) => {
              print(err),
              Fluttertoast.showToast(
                  msg: DaCaStrings.retrieveCurrentPositionError),
            });
  }

  void updateMapPosition(GoogleMapController controller, Position position) {
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: this.zoomAmount,
        ),
      ),
    );
  }
}
