import 'auth_provider.dart';
import 'auth_user.dart';
import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  final AuthProvider provider;

  @override
  Future<AuthUser> createNewAccountWithEmail(
          {required String email, required String password}) =>
      provider.createNewAccountWithEmail(email: email, password: password);

  @override
  Future<AuthUser> createNewAccountWithSms({required String phoneNumber}) =>
      provider.createNewAccountWithSms(phoneNumber: phoneNumber);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> logInWithEmail(
          {required String email, required String password}) =>
      provider.logInWithEmail(email: email, password: password);

  @override
  Future<AuthUser> logInWithSms({required String phoneNumber}) =>
      provider.logInWithSms(phoneNumber: phoneNumber);

  @override
  Future<void> sendPwReset({required String toEmail}) =>
      provider.sendPwReset(toEmail: toEmail);

  @override
  Future<void> sendVerificationEmail() => provider.sendVerificationEmail();

  @override
  Future<void> logOut() => provider.logOut();
}
