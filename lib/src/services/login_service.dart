import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soal_natura/src/utils/http_utils.dart';
import 'package:soal_natura/src/utils/preferences_utils.dart';

class LoginService extends ChangeNotifier {
  String _indentifier = '';
  String _password = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String get identifier => _indentifier;
  String get password => _password;
  GlobalKey<FormState> get formKey => _formKey;

  void setIdentifier(String value) {
    _indentifier = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  set setFormKey(GlobalKey<FormState> value) {
    _formKey = value;
    notifyListeners();
  }

  void handleLogin(
    BuildContext context, [
    bool mounted = true,
  ]) async {
    try {
      if (_formKey.currentState!.validate()) {
        final loginData = await Http.login(
          'api/auth/local',
          jsonEncode(
            {
              "identifier": _indentifier,
              "password": _password,
            },
          ),
        );

        await PreferencesUtils.putString(
          'token',
          loginData.data['jwt'],
        );
        await PreferencesUtils.putString(
          'username',
          jsonEncode(loginData.data['user']['username']),
        );
        await PreferencesUtils.putBool('isLogged', true);

        if (!mounted) return;

        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
