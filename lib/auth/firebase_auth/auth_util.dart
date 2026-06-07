import 'package:firebase_auth/firebase_auth.dart';

import '../base_auth_user_provider.dart';
import 'firebase_auth_manager.dart';

export 'firebase_auth_manager.dart';

final FirebaseAuthManager authManager = FirebaseAuthManager.instance;

String get currentUserEmail => currentUser?.email ?? '';

String get currentUserUid => currentUser?.uid ?? '';

String get currentUserDisplayName => currentUser?.displayName ?? '';

String get currentPhoneNumber => currentUser?.phoneNumber ?? '';

Stream<BaseAuthUser> campusLostFoundFirebaseUserStream() =>
    FirebaseAuth.instance.authStateChanges().map((user) {
      currentUser = CampusLostFoundFirebaseUser(user);
      return currentUser!;
    });

final jwtTokenStream = FirebaseAuth.instance
    .idTokenChanges()
    .asyncMap((user) => user?.getIdToken());
