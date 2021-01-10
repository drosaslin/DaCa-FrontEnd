import 'package:flutter/material.dart';
import 'package:daca/views/login_view.dart';
import 'package:daca/views/sign_up_view.dart';
// import 'login_page.dart';
// import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginView.tag: (context) => LoginView(),
    SignUpView.tag: (context) => SignUpView(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DaCa',
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
