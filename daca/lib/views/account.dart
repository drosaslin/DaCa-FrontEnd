import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhysicalModel(
        color: Colors.black,
        elevation: 8.0,
        child: Container(
          alignment: Alignment.center,
          color: Colors.amber,
          child: Text('Photo'),
          constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
        ),
      ),
    );
  }
}
