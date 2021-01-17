import 'package:daca/viewmodels/sign_up_view_model.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:flutter/material.dart';
import 'package:daca/public/strings.dart';
import 'package:daca/colors.dart';

class SignUpView extends StatelessWidget {
  static String tag = 'signUpView';

  final SignUpViewModel viewModel = SignUpViewModel();

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
            ],
          ),
        ),
      ),
    );
  }
}

class InputFormContent extends StatelessWidget {
  final SignUpViewModel viewModel;

  InputFormContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: DaCaStrings.userId),
          onChanged: (value) => this.viewModel.onUserChange(value),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: DaCaStrings.name),
          onChanged: (value) => this.viewModel.onNameChange(value),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: DaCaStrings.lastName),
          onChanged: (value) => this.viewModel.onLastNameChange(value),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: DaCaStrings.email),
          onChanged: (value) => this.viewModel.onEmailChange(value),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: DaCaStrings.password),
          obscureText: true,
          onChanged: (value) => this.viewModel.onPasswordChange(value),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: DaCaStrings.passwordRepeat),
          obscureText: true,
          onChanged: (value) => this.viewModel.onPasswordRepeatChange(value),
        ),
        GenderSelection(
          femaleImage: AssetImage('assets/images/female_icon.png'),
          maleImage: AssetImage('assets/images/male_icon.png'),
          // linearGradient: pinkRedGradient,
          selectedGenderIconBackgroundColor: Colors.indigo,
          checkIconAlignment: Alignment.centerRight,
          selectedGenderCheckIcon: null,
          onChanged: (Gender gender) {
            print(gender);
          },
          equallyAligned: true,
          animationDuration: Duration(milliseconds: 400),
          isCircular: false,
          isSelectedGenderIconCircular: true,
          opacityOfGradient: 0.6,
          padding: const EdgeInsets.all(3),
          size: 80,
        ),
      ],
    );
  }
}

class LoginButtonContent extends StatelessWidget {
  final SignUpViewModel viewModel;

  LoginButtonContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () => this.viewModel.onSignUp(),
          ),
        ),
      ],
    );
  }
}
