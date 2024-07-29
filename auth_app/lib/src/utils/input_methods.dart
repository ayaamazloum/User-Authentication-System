extension InputValidation on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword{
  final passwordRegExp = 
    RegExp(r"^.{8,}$");
    return passwordRegExp.hasMatch(this);
  }
}
