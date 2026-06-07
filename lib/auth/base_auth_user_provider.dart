class AuthUserInfo {
  const AuthUserInfo({
    this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
  });

  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
}

abstract class BaseAuthUser {
  bool get loggedIn;
  bool get emailVerified;

  AuthUserInfo get authUserInfo;

  String? get uid => authUserInfo.uid;
  String? get email => authUserInfo.email;
  String? get displayName => authUserInfo.displayName;
  String? get photoUrl => authUserInfo.photoUrl;
  String? get phoneNumber => authUserInfo.phoneNumber;
}

class CampusLostFoundFirebaseUser extends BaseAuthUser {
  CampusLostFoundFirebaseUser(this._user);

  final dynamic _user;

  @override
  bool get loggedIn => _user != null;

  @override
  bool get emailVerified => _user?.emailVerified ?? false;

  @override
  AuthUserInfo get authUserInfo => AuthUserInfo(
        uid: _user?.uid,
        email: _user?.email,
        displayName: _user?.displayName,
        photoUrl: _user?.photoURL,
        phoneNumber: _user?.phoneNumber,
      );
}

BaseAuthUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
