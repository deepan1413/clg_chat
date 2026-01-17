import 'package:clg_chat/components/my_logs.dart';
import 'package:clg_chat/features/profile/domain/repo/profile_repo.dart';
import 'package:clg_chat/features/profile/presentation/cubits/profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepo profileRepo;
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  Future<void> fetchUserProfile(String uid) async {
    MyLog.info("Working on fetchUserProfile profile_cubit.dart");
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchProfileUser(uid);
      if (user != null) {
        MyLog.success("user found fetchUserProfile profile_cubit.dart");

        emit(ProfilelLoaded(user));
      } else {
        MyLog.warning("user not found fetchUserProfile profile_cubit.dart");

        emit(ProfileError("user not found"));
      }
    } catch (e) {
      MyLog.error("$e at fetchUserProfile profile_cubit.dart");

      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateBio({required String uid, String? newBio}) async {
    MyLog.info("working on updateBio profile_cubit.dart");

    emit(ProfileLoading());
    try {
      final currentUser = await profileRepo.fetchProfileUser(uid);
      if (currentUser == null) {
        emit(ProfileError("failed to fetch user for profile update"));
        return;
      }
      final updatedProfile = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio,
      );
      await profileRepo.updateProfile(updatedProfile);
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError("failed  for profile update $e"));
    }
  }
}
