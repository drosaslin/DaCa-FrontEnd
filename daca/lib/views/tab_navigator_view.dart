import 'package:flutter/material.dart';
// import 'package:yuyu/page/homepage.dart';
// import 'package:yuyu/page/my_map.dart';
// import 'package:yuyu/page/account.dart';
// import 'package:yuyu/page/book_movie_collecction.dart';
// import 'package:yuyu/page/loginpage.dart';

void main() {
  runApp(TabNavigator());
}

class TabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        // routes: {
        //   '/screen1': (context) => new Screen1(),},
        home: Scaffold(
          // appBar: AppBar(
          //   title: Text("Cathy App"),
          // )
          // body: XD_Screen1(),
          body: BottomController(),
          // HomePage(),
          //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          //   floatingActionButton: FloatingActionButton(
          //     child: Icon(Icons.add),
          //     elevation: 10,
          //     backgroundColor: Color.fromARGB(255, 216, 226, 248),
          //     onPressed: () {
          //       print('press...');
          //     },
          // ),
        ));
  }
}

class TabController extends StatefulWidget {
  @override
  _TabControllerState createState() => _TabControllerState();
}

class _TabControllerState extends State<TabController> {
  int _currentIndex = 0;
  final pages = [HomePage(), MyMap(), Collection(), Account(), LoginPage()];

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
          // ignore: deprecated_member_use
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), title: Text('magazine')),
          BottomNavigationBarItem(
              icon: Icon(Icons.where_to_vote_sharp), title: Text('my map')),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined),
              title: Text('collection')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp), title: Text('account')),
          BottomNavigationBarItem(
              icon: Icon(Icons.vpn_key), title: Text('Login'))
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
