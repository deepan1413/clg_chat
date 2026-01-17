import 'package:clg_chat/components/my_logs.dart';
import 'package:clg_chat/features/auth/domain/entities/app_user.dart';
import 'package:clg_chat/features/auth/domain/repo/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final firebaseUser = firebaseAuth.currentUser;
      if (firebaseUser == null) return null;
      return AppUser(
        email: firebaseUser.email!,
        uid: firebaseUser.uid,
        name: '',
      );
    } catch (e) {
      MyLog.error(e.toString());
    }
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(
        email: email,
        uid: userCredential.user!.uid,
        name: '',
      );
      return user;
    } catch (e) {
      MyLog.error(e.toString());
      throw Exception("login failed  :  $e");
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(
        email: email,
        uid: userCredential.user!.uid,
        name: name,
      );
      await firebaseFirestore.collection("users").doc(user.uid).set(user.toJson());
      return user;
    } catch (e) {
      MyLog.error(e.toString());
      throw Exception("login failed  :  $e");
    }
  }
}
