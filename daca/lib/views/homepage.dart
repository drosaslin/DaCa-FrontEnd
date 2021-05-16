import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  var result;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            children: [
              TabBar(
                indicatorPadding: EdgeInsets.all(0.0),
                labelPadding: EdgeInsets.all(0.0),
                indicatorColor: Colors.yellow,
                tabs: [
                  Tab(
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.yellow,
                      child: Center(child: Text('Food')),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        color: Colors.green,
                        child: Center(child: Text('Travel')),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.redAccent,
                      child: Center(child: Text('Life')),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(color: Colors.yellow),
                    Container(color: Colors.green),
                    Container(color: Colors.redAccent),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
