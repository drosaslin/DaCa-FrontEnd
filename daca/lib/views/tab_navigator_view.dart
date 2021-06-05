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
  double height = 1;
  double width = 10;
  double heightDelta = 159;
  double widthDelta = 150;
  bool animationEnd = false;

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
            bottom: 67,
            child: Visibility(
              visible: animationEnd,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PhysicalModel(
                  color: Colors.amber,
                  shadowColor: Colors.amber,
                  elevation: 8,
                  child: Container(
                    width: width > 50 ? width - 50 : 0,
                    height: 1,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 40,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutQuart,
                width: width,
                height: height,
                child: CustomButtonShape(),
                onEnd: () {
                  setState(() {
                    animationEnd = true;
                  });
                },
              ),
            ),
          ),
          Positioned.fill(
            bottom: 12,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  setState(
                    () {
                      animationEnd = false;
                      width += widthDelta;
                      height += heightDelta;
                      heightDelta *= -1;
                      widthDelta *= -1;
                    },
                  );
                },
                child: PhysicalModel(
                  color: Colors.amber,
                  shadowColor: Colors.amber,
                  elevation: 8,
                  shape: BoxShape.circle,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: DaCaColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
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
    return Material(
      color: Colors.transparent,
      child: ClipPath(
        child: PhysicalModel(
          color: Colors.black,
          elevation: 8.0,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: DaCaColors.primaryColor,
            child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ExpandableFabButton(
                      text: 'Travel',
                      icon: Icons.map_outlined,
                    ),
                  ),
                  Expanded(
                    child: ExpandableFabButton(
                      text: 'Food',
                      icon: Icons.restaurant_menu_outlined,
                    ),
                  ),
                  Expanded(
                    child: ExpandableFabButton(
                      text: 'Life',
                      icon: Icons.family_restroom_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        clipper: CustomShape(),
      ),
    );
  }
}

class ExpandableFabButton extends StatelessWidget {
  final String text;
  final IconData icon;

  ExpandableFabButton({@required this.text, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print('$text tapped'),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              this.text,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Icon(
              this.icon,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;
    double box = 50;
    double halfBox = box / 2;
    double restPoint = height * 180 / 200;
    double anglePoint = (width / 2 - halfBox);
    double curve = width * 30 / 200;

    path.moveTo(0, height * 3 / 4);
    path.lineTo(0, height * 3 / 4);

    path.quadraticBezierTo(0, restPoint, curve, restPoint);

    path.lineTo(anglePoint - curve, restPoint);
    path.quadraticBezierTo(anglePoint, restPoint, anglePoint, height);

    path.lineTo(anglePoint, height);
    path.lineTo(anglePoint + box, height);
    path.quadraticBezierTo(
        anglePoint + box, restPoint, anglePoint + box + curve, restPoint);
    path.lineTo(width - curve, restPoint);

    path.quadraticBezierTo(width, restPoint, width, restPoint - curve);
    path.lineTo(width, curve);

    path.quadraticBezierTo(width, 0, width - curve, 0);

    path.lineTo(curve, 0);

    path.quadraticBezierTo(0, 0, 0, curve);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
