import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class GoogleService {
  final logger = Logger();
  static const String provider = 'google';
  GoogleSignIn _googleSignIn;

  Future<dynamic> loginGoogle(String clientId) async {
    _googleSignIn ??= GoogleSignIn(clientId: clientId);
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    assert(googleSignInAccount != null);
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    return googleSignInAuthentication.idToken;
  }

  void logoutGoogle(String clientId) async {
    _googleSignIn ??= GoogleSignIn(clientId: clientId);
    await _googleSignIn.signOut();
  }
}
