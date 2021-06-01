import 'package:daca/public/colors.dart';
import 'package:daca/viewmodels/map_search_view_model.dart';
import 'package:daca/viewmodels/tab_navigator_view_model.dart';
import 'package:daca/viewmodels/map_view_model.dart';
import 'package:daca/views/account.dart';
import 'package:daca/views/map_search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daca/views/customwidgets/ColoredSafeArea.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'book_movie_collecction.dart';
import 'homepage.dart';
import 'map_view.dart';

class TabNavigatorView extends StatelessWidget {
  static String tag = 'tabNavigatorView';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TabNavigatorViewModel>(
      create: (context) => TabNavigatorViewModel(),
      child: TabController(),
    );
  }
}

class TabController extends StatefulWidget {
  @override
  _TabControllerState createState() => _TabControllerState();
}

class _TabControllerState extends State<TabController>
    with TickerProviderStateMixin {
  int selectedPageIndex;
  List<Widget> pages;
  PageController pageController;
  final MapViewModel mapViewModel = MapViewModel();
  final MapSearchViewModel mapSearchViewModel = MapSearchViewModel();
  double height = 50;
  double heightDelta = 150;

  @override
  void initState() {
    super.initState();

    selectedPageIndex = 0;
    pages = [
      HomePage(),
      MapView(mapViewModel),
      Collection(),
      Account(),
    ];

    pageController = PageController(initialPage: selectedPageIndex);
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  void onTapChange() {
    setState(() {
      final viewModel =
          Provider.of<TabNavigatorViewModel>(context, listen: false);
      selectedPageIndex = viewModel.selectedIndex;
      pageController.jumpToPage(selectedPageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredSafeArea(
      color: DaCaColors.primaryColor,
      child: Stack(
        children: [
          Scaffold(
            body: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: pages,
            ),
            bottomNavigationBar:
                TabItemsWidget(onTabChangeCallback: this.onTapChange),
          ),
          Positioned.fill(
            bottom: 30,
            // left: MediaQuery.of(context).size.width / 2 - (height / 2),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutQuart,
                width: height,
                height: height,
                child: CustomButtonShape(),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  print('clicked');
                  setState(
                    () {
                      height += heightDelta;
                      heightDelta *= -1;
                    },
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TabItemsWidget extends StatelessWidget {
  final Function onTabChangeCallback;

  TabItemsWidget({@required this.onTabChangeCallback});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<TabNavigatorViewModel>(context, listen: false);

    return Consumer<TabNavigatorViewModel>(
      builder: (BuildContext context, value, Widget child) => BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                color: viewModel.magazineIconColor,
                icon: Icon(Icons.menu_book),
                onPressed: () => {
                  viewModel.onMagazineIconPress(),
                  this.onTabChangeCallback(),
                },
              ),
              IconButton(
                color: viewModel.travelIconColor,
                icon: Icon(Icons.where_to_vote_sharp),
                onPressed: () => {
                  viewModel.onTravelIconPress(),
                  this.onTabChangeCallback(),
                },
              ),
              SizedBox.shrink(),
              IconButton(
                color: viewModel.collectionIconColor,
                icon: Icon(Icons.movie_creation_outlined),
                onPressed: () => {
                  viewModel.onCollectionIconPress(),
                  this.onTabChangeCallback(),
                },
              ),
              IconButton(
                color: viewModel.accountIconColor,
                icon: Icon(Icons.account_circle_sharp),
                onPressed: () => {
                  viewModel.onAccountIconPress(),
                  this.onTabChangeCallback(),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButtonShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
      ),
      clipper: CustomShape(),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    double roundnessFactor = size.height / 8;
    // double roundnessFactor = 25;
    double bottomButtomHeight = size.height / 4;

    path.lineTo(0, size.height - bottomButtomHeight - roundnessFactor);
    path.quadraticBezierTo(0, size.height - bottomButtomHeight, roundnessFactor,
        size.height - bottomButtomHeight);

    path.lineTo(size.width - roundnessFactor, size.height - bottomButtomHeight);
    path.quadraticBezierTo(size.width, size.height - bottomButtomHeight,
        size.width, size.height - bottomButtomHeight - roundnessFactor);

    path.lineTo(size.width, roundnessFactor);
    path.quadraticBezierTo(size.width, 0, size.width - roundnessFactor, 0);

    path.lineTo(roundnessFactor, 0);
    path.quadraticBezierTo(0, 0, 0, roundnessFactor);

    path.moveTo(
        size.width / 2 - bottomButtomHeight, size.height - bottomButtomHeight);
    path.quadraticBezierTo(
        size.width / 2 - roundnessFactor,
        size.height - bottomButtomHeight,
        size.width / 2 - roundnessFactor,
        size.height - roundnessFactor);

    path.lineTo(
        size.width / 2 + roundnessFactor, size.height - roundnessFactor);
    // path.lineTo(
    // size.width / 2 - roundnessFactor, size.height - roundnessFactor);
    // path.quadraticBezierTo(size.width / 2 - roundnessFactor, size.height,
    //     size.width / 2, size.height);
    // path.quadraticBezierTo(size.width / 2 + roundnessFactor, size.height,
    //     size.width / 2 + roundnessFactor, size.height - roundnessFactor);
    path.quadraticBezierTo(
        size.width / 2 + roundnessFactor,
        size.height - bottomButtomHeight,
        size.width / 2 + bottomButtomHeight,
        size.height - bottomButtomHeight);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
