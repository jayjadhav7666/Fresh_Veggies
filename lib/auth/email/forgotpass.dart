import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordEmail {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {});
  }
}
