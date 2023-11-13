import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    print("started");
   try{
     // await _googleSignIn.signIn();
   }catch(e){

   }

    // print("got here ${googleUser?.email}");
    // // Obtain the auth details from the request
    // final GoogleSignInAuthentication? googleAuth =
    //     await googleUser?.authentication;
    // print("got here");
    // print("acc ${googleAuth?.accessToken}");
    // print("id ${googleAuth?.idToken}");
    // // Create a new credential
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );
    //
    // // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
