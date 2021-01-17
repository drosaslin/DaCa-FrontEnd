import 'package:flutter/material.dart';
import 'package:daca/views/my_map.dart';

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  var result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          color: Colors.amber,
          child: Text('Jump to B page'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {
            goToMyMap(context);
          },
        ),
        Text('FeedBack: $result')
      ],
    );
  }

  void goToMyMap(BuildContext context) async {
    result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyMap()));
  }
}
