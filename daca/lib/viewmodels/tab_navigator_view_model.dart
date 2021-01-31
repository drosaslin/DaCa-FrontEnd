import 'package:daca/public/colors.dart';
import 'package:daca/views/account.dart';
import 'package:daca/views/homepage.dart';
import 'package:daca/views/book_movie_collecction.dart';
import 'package:daca/views/travel_map_view.dart';
import 'package:flutter/cupertino.dart';

class TabNavigatorViewModel with ChangeNotifier {
  final selectedColor = DaCaColors.primaryColor;
  final unselectedColor = DaCaColors.tabUnselectedColor;

  Object currentView;
  HomePage magazineView;
  TravelMapView travelView;
  Collection collectionView;
  Account accountView;
  Color magazineIconColor;
  Color travelIconColor;
  Color collectionIconColor;
  Color accountIconColor;

  TabNavigatorViewModel() {
    this.magazineView = HomePage();
    this.currentView = this.magazineView;

    this.travelView = null;
    this.collectionView = null;
    this.accountView = null;

    this.magazineIconColor = this.selectedColor;
    this.travelIconColor = this.unselectedColor;
    this.collectionIconColor = this.unselectedColor;
    this.accountIconColor = this.unselectedColor;
  }

  void onMagazineIconPress() {
    if (this.magazineView == null) {
      this.magazineView = HomePage();
    }

    this.currentView = this.magazineView;
    deselectIcons();
    this.magazineIconColor = this.selectedColor;
    notifyListeners();
  }

  void onTravelIconPress() {
    if (this.travelView == null) {
      this.travelView = TravelMapView();
    }

    this.currentView = this.travelView;
    deselectIcons();
    this.travelIconColor = this.selectedColor;
    notifyListeners();
  }

  void onCollectionIconPress() {
    if (this.collectionView == null) {
      this.collectionView = Collection();
    }

    this.currentView = this.collectionView;
    deselectIcons();
    this.collectionIconColor = this.selectedColor;
    notifyListeners();
  }

  void onAccountIconPress() {
    if (this.accountView == null) {
      this.accountView = Account();
    }

    this.currentView = this.accountView;
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
