import 'package:clg_chat/features/auth/data/firebase_auth_repo.dart';
import 'package:clg_chat/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:clg_chat/features/auth/presentation/cubits/auth_states.dart';
import 'package:clg_chat/features/auth/presentation/pages/login_page.dart';
import 'package:clg_chat/features/auth/presentation/pages/register_page.dart';
import 'package:clg_chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authrepo = FirebaseAuthRepo();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authrepo)..checkAuth(),
      child: MaterialApp(
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Authenticated) {
              return LoginPage();
            }
            if (authState is Unauthenticated) {
              return RegisterPage();
            } else {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
          listener: (context, state) {},
        ),

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
