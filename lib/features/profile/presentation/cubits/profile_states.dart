import 'package:clg_chat/features/profile/domain/entities/profile_user.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileLoading extends ProfileStates {}

class ProfilelLoaded extends ProfileStates {
  final ProfileUser
   profileUser;
  ProfilelLoaded( this.profileUser);
}

class ProfileError extends ProfileStates {
  String message;
  ProfileError(this.message);
}
