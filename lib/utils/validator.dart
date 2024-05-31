class Validator {
  static String REGEX_PASSWORD = r'^.{8,}$';
  static String REGEX_RESET_PASSWORD = r'^.{8,}$';
  static String REGEX_PASSWORD_SIGNUP = r'^.{8,}$';
  static String REGEX_EMAIL =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regex = RegExp(REGEX_EMAIL);
  static RegExp regexPassword = RegExp(REGEX_PASSWORD);
  static RegExp regexResetPassword = RegExp(REGEX_RESET_PASSWORD);
  static RegExp regexPasswordSignUp = RegExp(REGEX_PASSWORD_SIGNUP);
}
