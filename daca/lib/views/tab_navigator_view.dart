import 'package:daca/public/colors.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/viewmodels/tab_navigator_view_model.dart';
import 'package:daca/views/account.dart';
import 'package:daca/views/place_search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daca/views/customwidgets/ColoredSafeArea.dart';

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

  @override
  void initState() {
    super.initState();

    final viewModel =
        Provider.of<TabNavigatorViewModel>(context, listen: false);

    selectedPageIndex = 0;
    pages = [
      HomePage(),
      MapView(viewModel.mapViewModel),
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
      viewModel.onOutsidePress();
      pageController.jumpToPage(selectedPageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TabNavigatorViewModel>(context, listen: true);

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
          Visibility(
            visible: viewModel.isTypeSelectionOpen(),
            child: GestureDetector(
              onTap: () => viewModel.onOutsidePress(),
              child: Container(
                color: DaCaColors.dacaGrey,
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 88,
              ),
            ),
          ),
          Positioned.fill(
            bottom: 66,
            child: Visibility(
              visible: viewModel.animationEnd,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PhysicalModel(
                  color: Colors.amber,
                  shadowColor: Colors.amber,
                  elevation: 8,
                  child: Container(
                    width: viewModel.expandableFabWidth > 50
                        ? viewModel.expandableFabWidth - 50
                        : 0,
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
                width: viewModel.expandableFabWidth,
                height: viewModel.expandableFabHeight,
                child: CustomButtonShape(),
                onEnd: () => viewModel.onAnimationEnd(),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 12,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => viewModel.onAnimationStart(),
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
              padding: EdgeInsets.only(left: 22, right: 22, top: 5, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ExpandableFabButton(
                      text: DaCaStrings.travelReview,
                      icon: Icons.map_outlined,
                    ),
                  ),
                  Expanded(
                    child: ExpandableFabButton(
                      text: DaCaStrings.foodReview,
                      icon: Icons.restaurant_menu_outlined,
                    ),
                  ),
                  Expanded(
                    child: ExpandableFabButton(
                      text: DaCaStrings.lifeReview,
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
    final viewModel =
        Provider.of<TabNavigatorViewModel>(context, listen: false);

    return InkWell(
      onTap: () => {
        viewModel.onReviewTypePress(this.text),
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: viewModel.placeSearchViewModel,
              child: PlaceSearchView(),
            ),
          ),
        ),
      },
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
