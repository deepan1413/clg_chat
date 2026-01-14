import 'package:clg_chat/features/profile/domain/entities/profile_user.dart';
import 'package:clg_chat/features/profile/domain/repo/profile_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProfileRepo implements ProfileRepo {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<ProfileUser?> fetchProfileUser(String uid) async {
    try {
      final docUser = await firebaseFirestore
          .collection("users")
          .doc(uid)
          .get();
      if (docUser.exists) {
        final userData = docUser.data();
        if (userData != null) {
          return ProfileUser(
            uid: uid,
            email: userData['email'],
            name: userData['name'],
            bio: userData['bio'],
            profileImageURL: userData['profileImage'].toString(),
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updateProfile) async {
    try {
      await firebaseFirestore.collection("users").doc(updateProfile.uid).update(
        {'bio': updateProfile.bio, 'profileImage': updateProfile.profileImageURL},
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
