class FormValidation {
  String? emailValidation(String email) {
    bool validateEmail = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
    if (validateEmail) {
      return null;
    } else {
      return 'Enter valid Email';
    }
  }

  String? passwordValidation(String password) {
    if (password.isEmpty || password.length < 6) {
      return 'Enter a valid password';
    } else {
      return null;
    }
  }

  String? stringValidation(String string) {
    if (string.isEmpty) {
      return 'Field cannot be empty';
    } else {
      return null;
    }
  }

  String? phoneValidation(String phone) {
    if (phone.isEmpty || phone.length < 10) {
      return 'Enter a valid phone number';
    } else {
      return null;
    }
  }
}
