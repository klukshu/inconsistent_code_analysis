import 'package:bloc/bloc.dart';
import '../auth_exeptions.dart';
import '../auth_provider.dart';
import '../auth_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthUninitialized({isLoading: true})) {
    on<AuthInitialize>((AuthInitialize event, Emitter<AuthState> emit) async {
      await provider.initialize();
      final AuthUser? user = provider.currentUser;
      if (user == null) {
        emit(const AuthLoggedOut(
          exception:  null, 
          isLoading: false,));
      } else if (true) {

      }
    });
    on<AuthLogInEmail>((AuthLogInEmail event, Emitter<AuthState> emit) async {
      emit(const AuthLoggedOut(
        exception: null, 
        isLoading: true, ));
      final String email = event.email;
      final String password = event.password;
      try {
        final AuthUser user =
            await provider.logInWithEmail(email: email, password: password);
        emit(AuthLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthLoginFailure(e));
      }
    });

    on<AuthChooseEmail>((AuthChooseEmail event, Emitter<AuthState> emit) {
      if (state is AuthSelectingAuthForNewAccount) {
        emit(const AuthRegisteringEmail());
      }
      if (state is AuthLoggedOut) {
        emit(const AuthLoggingInEmail());
      } else {
        throw GenericAuthException();
      }
    });
    on<AuthChooseSMS>((AuthChooseSMS event, Emitter<AuthState> emit) {
      if (state is AuthSelectingAuthForNewAccount) {
        emit(const AuthRegisteringSMS());
      }
      if (state is AuthLoggedOut) {
        emit(const AuthLoggingInSMS());
      } else {
        throw GenericAuthException();
      }
    });
    on<AuthCreateAccountEmail>(
        (AuthCreateAccountEmail event, Emitter<AuthState> emit) async {
      final email = event.email;
      try {
        await provider.createNewAccountWithEmail(
            email: event.email, password: event.password);
        await provider.sendVerificationEmail();
        emit(AuthNeedsVerification(isLoading: false));
      } on Exception catch (e) {
        emit(AuthRegisteringEmail(exception: e))
      }
    });

    on<AuthSendEmailVerification>(
        (AuthSendEmailVerification event, Emitter<AuthState> emit) async {
      await provider.sendVerificationEmail();
      emit(state);
    });
 
    on<AuthLogOut>((AuthLogOut event, Emitter<AuthState> emit) async {
      await provider.logOut();

      emit(AuthLoggedOut());
    });
    on<AuthShouldRegister>((AuthShouldRegister event, Emitter<AuthState> emit) {
      emit(AuthSelectingAuthForNewAccount());
    });
  }
}
