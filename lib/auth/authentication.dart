import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class Authentication {
  static final auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    try {
      if (await auth.canCheckBiometrics)
        return auth.authenticate(
          androidAuthStrings: AndroidAuthMessages(
            signInTitle: "Authentication Required",
          ),
          localizedReason: "Please Authenticate",
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        );
      return false;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
