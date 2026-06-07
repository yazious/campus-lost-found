import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../base_auth_user_provider.dart';
import 'email_auth.dart';

export '../base_auth_user_provider.dart';

class FirebaseAuthManager {
  FirebaseAuthManager._();

  static final FirebaseAuthManager _instance = FirebaseAuthManager._();
  static FirebaseAuthManager get instance => _instance;

  Future<BaseAuthUser?> signInWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final result = await emailSignInFunc(email, password);
      return result?.user == null
          ? null
          : CampusLostFoundFirebaseUser(result!.user);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message ?? e.code}')),
      );
      return null;
    }
  }

  Future<BaseAuthUser?> createAccountWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final result = await emailCreateAccountFunc(email, password);
      return result?.user == null
          ? null
          : CampusLostFoundFirebaseUser(result!.user);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message ?? e.code}')),
      );
      return null;
    }
  }

  Future resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await resetPasswordEmail(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message ?? e.code}')),
      );
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
