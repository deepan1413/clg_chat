import 'package:clg_chat/components/my_button.dart';
import 'package:clg_chat/components/my_text_field.dart';
import 'package:clg_chat/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  void Function()? onPressed;
  LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isForgetPassword = false;
  void login() {
    final String _email = emailController.text;
    final String _password = passwordController.text;
    final authCubit = context.read<AuthCubit>();
    if (_email.isEmpty && _password.isEmpty) {
      authCubit.login(_email, _password);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Check login")));
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            Text(
              "Our College",
              style: TextStyle(
                fontSize: 32,
                color: Color(0xfe21B3EC),
                fontWeight: FontWeight.bold,
              ),
            ),
            MyTextfield(label: 'Email'),
            MyTextfield(label: 'password'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(name: "Login", ontap: login),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: .end,
                children: [
                  Text('don\'t have account? '),

                  TextButton(
                    onPressed: widget.onPressed,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xfe21B3EC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
