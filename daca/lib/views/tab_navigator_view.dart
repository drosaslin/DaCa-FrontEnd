import 'package:daca/models/user.dart';
import 'package:daca/public/colors.dart';
import 'package:daca/viewmodels/tab_navigator_view_model.dart';
import 'package:daca/views/map_search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/customwidgets/ColoredSafeArea.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

class TabController extends StatelessWidget {
  TabController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TabNavigatorViewModel>(context);

    return ColoredSafeArea(
      color: DaCaColors.primaryColor,
      child: Scaffold(
        body: ColoredSafeArea(
          color: DaCaColors.primaryColor,
          child: viewModel.currentView,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: DaCaColors.primaryColor,
          onPressed: () => Navigator.of(context).pushNamed(MapSearchView.tag),
        ),
        bottomNavigationBar: TabItemsWidget(),
      ),
    );
  }
}

class CustomFAB extends StatefulWidget {
  @override
  _CustomFABState createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => print('FIRST CHILD'),
          label: 'First Child',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.brush, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => print('SECOND CHILD'),
          label: 'Second Child',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => print('THIRD CHILD'),
          labelWidget: Container(
            color: Colors.blue,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(6),
            child: Text('Custom Label Widget'),
          ),
        ),
      ],
    );
  }
}

class TabItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TabNavigatorViewModel>(context);

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
                onPressed: () => viewModel.onMagazineIconPress(),
              ),
              IconButton(
                color: viewModel.travelIconColor,
                icon: Icon(Icons.where_to_vote_sharp),
                onPressed: () => viewModel.onTravelIconPress(),
              ),
              SizedBox.shrink(),
              IconButton(
                color: viewModel.collectionIconColor,
                icon: Icon(Icons.movie_creation_outlined),
                onPressed: () => viewModel.onCollectionIconPress(),
              ),
              IconButton(
                color: viewModel.accountIconColor,
                icon: Icon(Icons.account_circle_sharp),
                onPressed: () => viewModel.onAccountIconPress(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
