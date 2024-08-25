import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  static final _googleSignIn = Platform.isAndroid
      ? GoogleSignIn()
      : GoogleSignIn(
          clientId:
              '251176585071-3rmrptlp5hqh09bnr7vdnj2dglns6efl.apps.googleusercontent.com',
        );
  static Future<UserCredential?> login() => signInWithGoogle();
  static Future signOut = _googleSignIn.signOut();
}

Future<UserCredential?> signInWithGoogle() async {
  log("Google Sign In Clicked");
  try {
    log('Entering the try block for Google Sign-In');

    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    log('GoogleSignInAccount: $googleSignInAccount');

    if (googleSignInAccount == null) {
      log('Google Sign-In process was canceled by the user');
      return null;
    }

    log('Proceeding to authenticate with GoogleSignInAccount');

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    log('GoogleSignInAuthentication: accessToken=${googleSignInAuthentication.accessToken}, idToken=${googleSignInAuthentication.idToken}');

    final authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    log('AuthCredential created: $authCredential');

    try {
      log('Attempting Firebase sign-in with the credential');
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      log('Firebase sign-in successful: $userCredential');
      return userCredential;
    } catch (e) {
      log('Firebase sign-in failed: $e');
    }
  } on PlatformException catch (e) {
    if (e.code == 'popup_closed_by_user') {
      log('Google sign-in was canceled by the user');
    } else if (e.code == 'sign_in_failed') {
      log('Google sign-in failed: ${e.message}');
    } else {
      log('Platform exception occurred: ${e.message}');
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'Unexpected error: $e');
    log('Unexpected error: $e');
  }

  log('Google Sign-In process ended with null result');
  return null;
}

//169376134779-03tmms8jvrnreup0a6cgiheft8d564vd.apps.googleusercontent.com

signout() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? boardingCount = prefs.getInt('boardingCount');
    boardingCount = boardingCount;
    prefs.clear();
    prefs.setInt('boardingCount', boardingCount ?? 0);
    await GoogleSignIn().signOut();
    await GoogleSignIn().disconnect();
  } catch (e, stackTrace) {
    log(e.toString());
    log(stackTrace.toString());
  }
}
