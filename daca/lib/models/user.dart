import 'package:daca/public/variables.dart';

class User {
  String userId;
  String firstName;
  String lastName;
  String email;
  String gender;
  DateTime birthday;

  User(
      {this.userId,
      this.email,
      this.firstName,
      this.lastName,
      this.gender,
      this.birthday});

  factory User.fromJson(final json) {
    print(json);
    return User(
      userId: json[DaCaVariables.userIdField],
      email: json[DaCaVariables.userEmailField],
      firstName: json[DaCaVariables.userNameField],
      lastName: json[DaCaVariables.userLastNameField],
      gender: json[DaCaVariables.userGenderField],
      birthday: DateTime.parse(json[DaCaVariables.userBirthdayField]),
    );
  }

  Map<String, dynamic> toJson() => {
        DaCaVariables.userIdField: this.userId,
        DaCaVariables.userEmailField: this.email,
        DaCaVariables.userNameField: this.firstName,
        DaCaVariables.userLastNameField: this.lastName,
        DaCaVariables.userGenderField: this.gender,
        DaCaVariables.userBirthdayField: this.birthday,
      };
}
