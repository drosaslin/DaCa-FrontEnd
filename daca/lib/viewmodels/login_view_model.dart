import 'package:daca/views/sign_up_view.dart';
import 'package:daca/models/user.dart';
import 'package:daca/views/tab_navigator_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:daca/repositories/user_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:daca/public/exceptions.dart';

class LoginViewModel {
  final UserRepository repository = UserRepository();
  User user;
  String userId;
  String password;

  LoginViewModel({this.userId = '', this.password = ''});

  void onUserChange(String userId) {
    this.userId = userId;
  }

  void onPasswordChange(String password) {
    this.password = password;
  }

  Future<void> onLogin(BuildContext context) async {
    try {
      this.user =
          await this.repository.getByIdAndPassword(this.userId, this.password);
      Navigator.of(context).pushNamed(TabNavigatorView.tag);
    } on InvalidCredentialsException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    }
  }

  void onSignUp(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        SignUpView.tag, (Route<dynamic> route) => false);
  }

  void onGoogleLogin() {
    print('google logging in');
  }

  void onFacebookLogin() {
    print('facebook logging in');
  }
}
