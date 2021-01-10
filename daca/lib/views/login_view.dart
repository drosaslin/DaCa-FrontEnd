import 'package:flutter/material.dart';
import 'package:daca/strings.dart';
import 'package:daca/colors.dart';
import 'package:daca/viewmodels/login_view_model.dart';

class LoginView extends StatelessWidget {
  static String tag = 'loginView';

  final LoginViewModel viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DaCaColors.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 70, top: 30, right: 70, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputFormContent(this.viewModel),
              LoginButtonContent(this.viewModel),
              SocialMediaLoginContent(this.viewModel),
            ],
          ),
        ),
      ),
    );
  }
}

class InputFormContent extends StatelessWidget {
  final LoginViewModel viewModel;

  InputFormContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: DaCaStrings.userId),
          onChanged: (value) => viewModel.onUserChange(value),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: DaCaStrings.password),
          obscureText: true,
          onChanged: (value) => viewModel.onPasswordChange(value),
        ),
      ],
    );
  }
}

class LoginButtonContent extends StatelessWidget {
  final LoginViewModel viewModel;

  LoginButtonContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 0, top: 10, right: 15, bottom: 0),
          child: RaisedButton(
            color: Color.fromARGB(255, 250, 250, 250),
            child: Text(
              DaCaStrings.login,
              style: TextStyle(
                color: Color.fromARGB(255, 100, 100, 100),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onPressed: () {
              this.viewModel.onLogin(context);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 10, right: 0, bottom: 0),
          child: RaisedButton(
            color: Color.fromARGB(255, 250, 250, 250),
            child: Text(
              DaCaStrings.signup,
              style: TextStyle(
                color: Color.fromARGB(255, 100, 100, 100),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onPressed: () => this.viewModel.onSignUp(context),
          ),
        ),
      ],
    );
  }
}

class SocialMediaLoginContent extends StatelessWidget {
  final LoginViewModel viewModel;

  SocialMediaLoginContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 0, top: 5, right: 5, bottom: 0),
          child: RaisedButton(
            color: Colors.redAccent,
            child: Text(
              DaCaStrings.googleButtonText,
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () => this.viewModel.onGoogleLogin(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 5, top: 5, right: 0, bottom: 0),
          child: RaisedButton(
            color: Colors.blueAccent,
            child: Text(
              DaCaStrings.facebookButtonText,
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () => this.viewModel.onFacebookLogin(),
          ),
        )
      ],
    );
  }
}
