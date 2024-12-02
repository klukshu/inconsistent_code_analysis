import 'package:flutter/foundation.dart' show immutable;

import '../auth_user.dart';

@immutable
abstract class AuthState {

  final bool isLoading;
  final String? loadingText;
  const AuthState({required this.isLoading, this.loadingText = 'Loading...'});
}

final class AuthUninitialized extends AuthState {
  const AuthUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

final class AuthLoggedIn extends AuthState {
  const AuthLoggedIn({required super.isLoading, required this.user});
  final AuthUser user;
}

final class AuthLoginFailure extends AuthState {
  const AuthLoginFailure(e, {required super.isLoading, required this.exception});
  final Exception exception;
}

final class AuthNeedsVerification extends AuthState {
  const AuthNeedsVerification({required super.isLoading});
}

final class AuthLoggedOut extends AuthState {
  const AuthLoggedOut({ this.exception, required super.isLoading});
  final Exception? exception;
}

class AuthSelectingAuthForNewAccount extends AuthState {
  const AuthSelectingAuthForNewAccount({required super.isLoading});
}

class AuthRegisteringEmail extends AuthState {
  const AuthRegisteringEmail(
      {required super.isLoading, this.exception});
  final Exception? exception;
}

class AuthRegisteringSMS extends AuthState {
  const AuthRegisteringSMS({required super.isLoading});
}

class AuthLoggingInSMS extends AuthState {
  const AuthLoggingInSMS({required super.isLoading});
}

class AuthLoggingInEmail extends AuthState {
  const AuthLoggingInEmail({required super.isLoading});
}
