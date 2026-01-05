import 'package:clg_chat/features/auth/domain/entities/app_user.dart';
import 'package:clg_chat/features/auth/domain/repos/auth_repo.dart';
import 'package:clg_chat/features/auth/presentation/cubits/auth_states.dart';
import 'package:clg_chat/mylogs/mylogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentuser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());
  void checkAuth() async {
    emit(AuthLoading());
    MyLog.info("AuthLoading on CheckAuth");
    final AppUser? user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentuser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  AppUser? get currentUser => _currentuser;

  Future<void> login(String email, String password) async {
    try {
      MyLog.info("AuthLoading on Login");
      emit(AuthLoading());

      final user = await authRepo.loginWithEmailAndPassword(email, password);
      if (user != null) {
        _currentuser = user;
        emit(Authenticated(user));
      } else {
        emit(AuthError("Invalid email or password"));
        emit(Unauthenticated());
      }
    } catch (e) {
      AuthError('Auth Error : $e');
      emit(Unauthenticated());
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      MyLog.info("AuthLoading on Register");

      final user = await authRepo.registerWithEmailAndPassword(
        name,
        email,

        password,
      );
      if (user != null) {
        _currentuser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      AuthError('Auth Error : $e');
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    MyLog.info("AuthLoading on Logout");

    await authRepo.logout();
    emit(Unauthenticated());
  }

  Future<String> forgetpassword(String email) async {
    try {
      final message = await authRepo.sendPasswordResetEmail(email);
      return message;
    } catch (e) {
      return "Error at logut $e";
    }
  }

  Future<void> signInwithGoogle() async {
    try {
      emit(AuthLoading());
      final user = await authRepo.signInWithGoogle();
      if (user != null) {
        _currentuser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      AuthError('Auth Error : $e');
      emit(Unauthenticated());
    }
  }
}
