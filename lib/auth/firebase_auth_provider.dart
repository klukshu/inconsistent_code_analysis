import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import 'auth_exeptions.dart';
import 'auth_provider.dart' as auth_provider;
import 'auth_user.dart';

class FirebaseAuthProvider implements auth_provider.AuthProvider {
  @override
  Future<AuthUser> logInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final AuthUser? user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExeption();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/user-not-found':
          throw UserNotFoundAuthException();
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebase_auth/wrong-password':
          throw WrongPasswordAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<AuthUser> createNewAccountWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final AuthUser? user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExeption();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/user-not-found':
          throw UserNotFoundAuthException();
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebase_auth/wrong-password':
          throw WrongPasswordAuthException();
        default:
          throw GenericAuthException();
      }
    }
  }

  @override
  Future<AuthUser> logInWithSms({required String phoneNumber}) async {
    // TODO: implement signInWithPhoneNumber
    throw UnimplementedError();
    /*  
    try {
      FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException {
      throw GenericAuthException();
    }
*/
  }

  @override
  AuthUser? get currentUser {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.reload();

      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<void> sendPwReset({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebase_auth/user-not-found':
          throw UserNotFoundAuthException();
        default:
          throw GenericAuthException();
      }
    }
  }

  @override
  Future<void> sendVerificationEmail() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthExeption();
    }
  }

  @override
  Future<void> logOut() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthExeption();
    }
  }

  @override
  Future<AuthUser> createNewAccountWithSms({required String phoneNumber}) {
    // TODO: implement createNewAccountWithSms
    throw UnimplementedError();
  }
}
