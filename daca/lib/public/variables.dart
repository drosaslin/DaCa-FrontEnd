import 'dart:io' show Platform;

class DaCaVariables {
  static String googleApiKey = (Platform.isAndroid)
      ? 'AIzaSyBOGs6Ob63c7VYH-vIlMfgQ9EO4aAKPmKI'
      : 'AIzaSyBbrePxipa6udHJ3eC4efldw6O6j9ii_U0';

  // User Api Fields
  static const userIdField = 'username';
  static const userPasswordField = 'password';
  static const userEmailField = 'email';
  static const userNameField = 'first_name';
  static const userLastNameField = 'last_name';
  static const userGenderField = 'gender';
  static const userBirthdayField = 'birthday';

  // Image Api Fields
  static const imageIdField = 'id';
  static const imageReviewIdField = 'review';
  static const imageField = 'image';

  // Local Storage Fields
  static const jwtToken = 'jwt';
  static const jwtRefreshToken = 'jwtRefresh';
  static const userIdTokenField = 'user_id';

  // Backend Api Fields
  static const userBackendField = 'user';
  static const jwtTokenBackendField = 'access_token';
  static const jwtRefreshTokenBackendField = 'refresh_token';

  // File Formats
  static const imageFormat = 'jpeg';

  // Http Request Values
  static const postMethod = 'POST';
  static const getMethod = 'GET';
  static const imageMediaType = 'image';
}
