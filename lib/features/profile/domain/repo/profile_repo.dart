import 'package:clg_chat/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> fetchProfileUser(String uid);
  Future<void> updateProfile(ProfileUser updateProfile);
}
