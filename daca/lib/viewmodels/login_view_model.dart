import 'package:daca/views/sign_up_view.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel {
  String userId;
  String password;

  LoginViewModel({this.userId = '', this.password = ''});

  void onUserChange(String userId) {
    this.userId = userId;
  }

  void onPasswordChange(String password) {
    this.password = password;
  }

  void onLogin(BuildContext context) {
    print('logging in');
  }

  void onSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(SignUpView.tag);
  }

  void onGoogleLogin() {
    print('google logging in');
  }

  void onFacebookLogin() {
    print('facebook logging in');
  }
}
