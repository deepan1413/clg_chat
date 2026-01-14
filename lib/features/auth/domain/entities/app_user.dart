class AppUser {
  String uid;
  String email;
  String name;
  AppUser({required this.uid, required this.email, required this.name});

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'name': name};
  }

  factory AppUser.fromJson(Map<String, dynamic> UserJson) {
    return AppUser(
      uid: UserJson['uid'],
      email: UserJson['email'],
      name: UserJson['name'],
    );
  }
}
