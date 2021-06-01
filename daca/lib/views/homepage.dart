import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  var result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            child: ReviewTypeRow(),
          ),
          Container(
            height: 600,
            color: Colors.lightBlue,
          ),
        ],
      ),
    );
  }
}

class ReviewTypeRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReviewTypeContainer(
            color: Colors.amber,
            text: Text('Travel'),
            selected: true,
          ),
          ReviewTypeContainer(
            color: Colors.green,
            text: Text('Food'),
            selected: false,
          ),
          ReviewTypeContainer(
            color: Colors.blue,
            text: Text('Life'),
            selected: false,
          ),
        ],
      ),
    );
  }
}

class ReviewTypeContainer extends StatelessWidget {
  final Color color;
  final Text text;
  final bool selected;

  ReviewTypeContainer(
      {@required this.color, @required this.text, @required this.selected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => print('Tapped'),
        child: Container(
          margin: EdgeInsets.only(top: selected ? 0 : 10),
          child: Center(
            child: text,
          ),
          decoration: BoxDecoration(
            color: this.color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }
}
