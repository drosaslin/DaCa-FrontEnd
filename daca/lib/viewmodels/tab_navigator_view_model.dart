import 'package:daca/public/colors.dart';
import 'package:daca/viewmodels/map_view_model.dart';
import 'package:flutter/cupertino.dart';

import 'map_search_view_model.dart';

class TabNavigatorViewModel with ChangeNotifier {
  final selectedColor = DaCaColors.primaryColor;
  final unselectedColor = DaCaColors.dacaGrey;
  final MapViewModel mapViewModel = MapViewModel();
  final MapSearchViewModel mapSearchViewModel = MapSearchViewModel();

  int selectedIndex;
  Color magazineIconColor;
  Color travelIconColor;
  Color collectionIconColor;
  Color accountIconColor;

  TabNavigatorViewModel() {
    this.selectedIndex = 0;
    this.magazineIconColor = this.selectedColor;
    this.travelIconColor = this.unselectedColor;
    this.collectionIconColor = this.unselectedColor;
    this.accountIconColor = this.unselectedColor;
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
}
