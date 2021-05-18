import 'package:flutter/material.dart';
import 'package:daca/views/login_view.dart';
import 'package:daca/views/sign_up_view.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/views/tab_navigator_view.dart';
import 'package:daca/views/map_search_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginView.tag: (context) => LoginView(),
    SignUpView.tag: (context) => SignUpView(),
    TabNavigatorView.tag: (context) => TabNavigatorView(),
    MapSearchView.tag: (context) => MapSearchView(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: DaCaStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginView(),
      routes: routes,
    );
  }
}
