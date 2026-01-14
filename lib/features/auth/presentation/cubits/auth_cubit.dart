import 'package:clg_chat/components/mylogs.dart';
import 'package:clg_chat/features/auth/domain/entities/app_user.dart';
import 'package:clg_chat/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clg_chat/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  void checkAuth() async {
    emit(AuthLoading());
    MyLog.info("AuthLoading on CheckAuth");
    final AppUser? user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  AppUser? get currentUser => _currentUser;

  Future<void> login(String email, String password) async {
    try {
      MyLog.info("AuthLoading on Login");
      emit(AuthLoading());

      final user = await authRepo.loginWithEmailAndPassword(email, password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
     MyLog.success("user found $user");

      } else {
      MyLog.warning("user null $user ");

        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError('Auth Error : $e'));
      emit(Unauthenticated());
      MyLog.info(" Error on login {AuthCubit.dart} $e");
    }
  }

  Future<void> register(String name, String email, String password) async {
   try {
      MyLog.info("AuthLoading on Login");
      emit(AuthLoading());

      final user = await authRepo.registerWithEmailAndPassword(name,email, password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError('Auth Error : $e'));
      emit(Unauthenticated());
      MyLog.info("Error on login $e");
    }
  }
  Future<void> logout() async {
    emit(AuthLoading());
    MyLog.info("AuthLoading on Logout");

    await authRepo.logout();
    emit(Unauthenticated());
  }
}
