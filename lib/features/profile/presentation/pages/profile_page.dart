import 'package:cached_network_image/cached_network_image.dart';
import 'package:clg_chat/features/auth/domain/entities/app_user.dart';
import 'package:clg_chat/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:clg_chat/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:clg_chat/features/profile/presentation/cubits/profile_states.dart';
import 'package:clg_chat/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final authcubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is ProfilelLoaded) {
          final user = state.profileUser;
          return Scaffold(
            appBar: AppBar(
              title: Text(user.name),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(user: user),
                      ),
                    );
                  },
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  Text(user.email),
                  Text(user.name),
                  Text(user.bio),
                  SizedBox(
                    height: 100,width: 100,
                    child: CachedNetworkImage(imageUrl: user.profileImageURL)),
                  TextButton(
                    onPressed: () {
                      authcubit.logout();
                    },
                    child: Text('data'),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is ProfileLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return Center(child: Text("no profile found"));
        }
      },
    );
  }
}
