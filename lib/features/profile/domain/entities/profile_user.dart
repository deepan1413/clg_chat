import 'package:clg_chat/features/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageURL;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.name,
    required this.bio,
    required this.profileImageURL,
  });

  ProfileUser copyWith({String? newBio, String? newProfileImage}) {
    return ProfileUser(
      uid: uid,
      email: email,
      name: name,
      bio: newBio ?? bio,
      profileImageURL: newProfileImage ?? profileImageURL,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'profileImage': profileImageURL,
    };
  }

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      bio: json['bio'] ?? '',
      profileImageURL: json['profileImage'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ProfileUser(uid: $uid, email: $email, name: $name, bio: $bio, profileImage: $profileImageURL)';
  }
}
