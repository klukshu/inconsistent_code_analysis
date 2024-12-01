import 'auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> logInWithEmail({
    required String email,
    required String password,
  });

  Future<AuthUser> createNewAccountWithEmail({
    required String email,
    required String password,
  });

  Future<AuthUser> logInWithSms({
    required String phoneNumber,
  });
  Future<AuthUser> createNewAccountWithSms({
    required String phoneNumber,
  });

  Future<void> sendPwReset({required String toEmail});

  Future<void> sendVerificationEmail();

  Future<void> logOut();
}
