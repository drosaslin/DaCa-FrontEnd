import 'package:daca/models/user.dart';
import 'package:daca/public/colors.dart';
import 'package:daca/viewmodels/map_view_model.dart';
import 'package:flutter/cupertino.dart';

import 'place_search_view_model.dart';

class TabNavigatorViewModel with ChangeNotifier {
  final selectedColor = DaCaColors.primaryColor;
  final unselectedColor = DaCaColors.dacaGrey;

  double expandableFabHeight = 1;
  double expandableFabWidth = 10;
  double expandableFabHeightDelta = 159;
  double expandableFabWidthDelta = 150;

  MapViewModel mapViewModel;
  PlaceSearchViewModel placeSearchViewModel;
  User user;

  int selectedIndex;
  bool animationEnd;
  Color magazineIconColor;
  Color travelIconColor;
  Color collectionIconColor;
  Color accountIconColor;

  TabNavigatorViewModel(User user) {
    this.selectedIndex = 0;
    this.animationEnd = false;
    this.magazineIconColor = this.selectedColor;
    this.travelIconColor = this.unselectedColor;
    this.collectionIconColor = this.unselectedColor;
    this.accountIconColor = this.unselectedColor;
    this.user = user;

    this.mapViewModel = MapViewModel(this.user);
    this.placeSearchViewModel = PlaceSearchViewModel(this.user);
  }

  void onMagazineIconPress() {
    this.selectedIndex = 0;
    deselectIcons();
    this.magazineIconColor = this.selectedColor;
    notifyListeners();
  }

  void onTravelIconPress() {
    this.selectedIndex = 1;
    deselectIcons();
    this.travelIconColor = this.selectedColor;
    notifyListeners();
  }

  void onCollectionIconPress() {
    this.selectedIndex = 2;
    deselectIcons();
    this.collectionIconColor = this.selectedColor;
    notifyListeners();
  }

  void onAccountIconPress() {
    this.selectedIndex = 3;
    deselectIcons();
    this.accountIconColor = this.selectedColor;
    notifyListeners();
  }

  void deselectIcons() {
    this.magazineIconColor = this.unselectedColor;
    this.travelIconColor = this.unselectedColor;
    this.collectionIconColor = this.unselectedColor;
    this.accountIconColor = this.unselectedColor;
  }

  void onReviewTypePress(String type) {
    this.placeSearchViewModel.clearObservers();
    this.placeSearchViewModel.registerObserver(this.mapViewModel);
    this.placeSearchViewModel.type = type.toLowerCase();
    print(this.placeSearchViewModel.type);
  }

  void onOutsidePress() {
    if (isTypeSelectionOpen()) {
      onAnimationStart();
    }
  }

  bool isTypeSelectionOpen() {
    return (this.expandableFabHeightDelta < 0);
  }

  void onAnimationStart() {
    this.animationEnd = false;

    this.expandableFabWidth += this.expandableFabWidthDelta;
    this.expandableFabHeight += this.expandableFabHeightDelta;

    this.expandableFabWidthDelta *= -1;
    this.expandableFabHeightDelta *= -1;

    notifyListeners();
  }

  void onAnimationEnd() {
    this.animationEnd = true;
    notifyListeners();
  }
}
