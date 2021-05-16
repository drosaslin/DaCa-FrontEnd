import 'package:flutter/cupertino.dart';

class HomePageViewModel extends ChangeNotifier {
  bool isFoodSelected;
  bool isTravelSelected;
  bool isLifeSelected;

  HomePageViewModel() {
    this.isFoodSelected = true;
    this.isTravelSelected = false;
    this.isLifeSelected = false;
  }
}
