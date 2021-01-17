import 'package:flutter/material.dart';
import 'package:daca/views/homepage.dart';
import 'package:daca/views/account.dart';
import 'package:daca/views/book_movie_collecction.dart';
import 'package:daca/views/travel_map_view.dart';
import 'package:daca/public/strings.dart';

class TabNavigatorView extends StatelessWidget {
  static String tag = 'tabNavigatorView';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: TabController(),
      ),
    );
  }
}

class TabController extends StatefulWidget {
  @override
  _TabControllerState createState() => _TabControllerState();
}

class _TabControllerState extends State<TabController> {
  int _currentIndex = 0;
  final pages = [
    HomePage(),
    TravelMapView(),
    Collection(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(Icons.chat_outlined)),
        ],
        backgroundColor: Colors.amber,
        title: Text('DaCa'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            title: Text('magazine'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.where_to_vote_sharp),
            title: Text(DaCaStrings.tabMapText),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined),
              title: Text('collection')),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            title: Text('account'),
          ),
        ],
        currentIndex: _currentIndex,
        backgroundColor: Colors.black12,
        fixedColor: Colors.amber,
        onTap: _onTtemClick,
        unselectedItemColor: Colors.black12,
      ),
    );
  }

  void _onTtemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
