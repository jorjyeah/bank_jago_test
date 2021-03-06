import 'package:bank_jago_test/helper.dart';

extension StringValidation on String {
  Result isEmail() {
    if (this == null || this.isEmpty) {
      return Result(false, "Email cannot be empty");
    }
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(this)) {
      return Result(false, "Please input valid email");
    }
    return Result(true, null);
  }

  bool isContainLowercase() {
    if (this == null || this.isEmpty) {
      return false;
    }
    const pattern = r'^(?=.*?[a-z])';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }

  bool isContainUppercase() {
    if (this == null || this.isEmpty) {
      return false;
    }
    const pattern = r'^(?=.*?[A-Z])';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }

  bool isContainNumber() {
    if (this == null || this.isEmpty) {
      return false;
    }
    const pattern = r'^(?=.*?[0-9])';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }

  bool isContainChar() {
    if (this == null || this.isEmpty) {
      return false;
    }
    const pattern = r'^.{8,}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }

  int complexity() {
    if (this == null || this.isEmpty) {
      return 0;
    } else {
      if (this.isContainUppercase() && this.isContainChar() && this.isContainUppercase() && this.isContainNumber()) {
        return 3;
      } else if (this.isContainChar() && this.isContainLowercase() && this.isContainUppercase()) {
        return 2;
      } else if ((this.isContainLowercase() || this.isContainUppercase()) &&
          (!this.isContainNumber() || !this.isContainChar())) {
        return 1;
      } else {
        return 0;
      }
    }
  }
}
