import 'package:flutter/material.dart';

class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  final Color color;

  ColoredSafeArea({@required this.child, this.color = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.color,
      child: SafeArea(
        child: this.child,
      ),
    );
  }
}
