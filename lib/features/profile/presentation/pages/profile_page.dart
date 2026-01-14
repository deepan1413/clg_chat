import 'package:clg_chat/features/auth/domain/entities/app_user.dart';
import 'package:clg_chat/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
  final authcubit= context.read<AuthCubit>();
  final AppUser? appUser=authcubit.currentUser;
    return  Scaffold(
      appBar: AppBar(title: Text(appUser!.email),),
      body: Column()
      
    );
  }
}
