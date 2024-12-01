import 'package:flutter/foundation.dart' show immutable;

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthInitialize extends AuthEvent {
  const AuthInitialize();
}

final class AuthLogIn extends AuthEvent {}

final class AuthLogInEmail extends AuthEvent {
  const AuthLogInEmail({required this.email, required this.password});
  final String email;
  final String password;
}

final class AuthLogInSMS extends AuthEvent {
  const AuthLogInSMS(this.sms);
  final String sms;
}

final class AuthLogOut extends AuthEvent {
  const AuthLogOut();
}

final class AuthShouldRegister extends AuthEvent {
  const AuthShouldRegister();
}

final class AuthChooseEmail extends AuthEvent {
  const AuthChooseEmail();
}

final class AuthChooseSMS extends AuthEvent {
  const AuthChooseSMS();
}

final class AuthCreateAccountEmail extends AuthEvent {
  const AuthCreateAccountEmail({required this.email, required this.password});
  final String email;
  final String password;
}

final class AuthSendEmailVerification extends AuthEvent {
  const AuthSendEmailVerification();
}
