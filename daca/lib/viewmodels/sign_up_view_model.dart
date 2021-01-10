class SignUpViewModel {
  String userId;
  String name;
  String lastName;
  String email;
  String gender;
  String password;
  String passwordRepeat;

  SignUpViewModel() {
    this.userId = '';
    this.name = '';
    this.lastName = '';
    this.email = '';
    this.gender = '';
    this.password = '';
    this.passwordRepeat = '';
  }

  void onSignUp() {
    print('press');
  }

  void onUserChange(String userId) {
    this.userId = userId;
  }

  void onPasswordChange(String password) {
    this.password = password;
  }

  void onPasswordRepeatChange(String passwordRepeat) {
    this.passwordRepeat = passwordRepeat;
  }

  void onNameChange(String name) {
    this.name = name;
  }

  void onLastNameChange(String lastName) {
    this.lastName = lastName;
  }

  void onEmailChange(String email) {
    this.email = email;
  }

  void onGenderChange(String gender) {
    this.gender = gender;
  }
}
