import 'package:firebase_auth/firebase_auth.dart' show User;

class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    required this.isEmailVerified,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        id: user.uid,
        email: user.email!,
        isEmailVerified: user.emailVerified,
      );
  final String id;
  final String email;
  final bool isEmailVerified;
}