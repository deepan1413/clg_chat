import 'package:clg_chat/features/auth/data/firebase_auth_repo.dart';
import 'package:clg_chat/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:clg_chat/features/auth/presentation/cubits/auth_states.dart';
import 'package:clg_chat/features/auth/presentation/pages/auth_page.dart';
import 'package:clg_chat/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authRepo = FirebaseAuthRepo();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: BlocConsumer<AuthCubit,AuthState>(
        builder:(context, authState) {
          if(authState is Unauthenticated){
            return AuthPage();
          }
          if(authState is Authenticated
          ){
            return HomePage();
          }else{
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          }
        }
      
       , listener: (context, state) {
         
       },)),
    );
  }
}
