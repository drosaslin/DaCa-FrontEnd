import 'package:flutter/material.dart';

class MyMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_location_alt_outlined),
          elevation: 10,
          backgroundColor: Colors.amber,
          onPressed: () {
            print('press...');
          }),
      body: Column(children: <Widget>[
        Center(child: Text('My Map')),

         ]),
    );
  }
}
