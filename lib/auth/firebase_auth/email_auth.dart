import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> emailSignInFunc(
  String email,
  String password,
) async {
  return FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email.trim(),
    password: password,
  );
}

Future<UserCredential?> emailCreateAccountFunc(
  String email,
  String password,
) async {
  return FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email.trim(),
    password: password,
  );
}

Future<void> resetPasswordEmail(String email) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
}
