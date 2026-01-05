import 'package:clg_chat/components/mybutton.dart';
import 'package:clg_chat/components/mytextfield.dart';
import 'package:clg_chat/mylogs/mylogs.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isForgetPassword = false;

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
              child: MyButton(name: "Login", ontap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: .end,
                children: [
                  Text('don\'t have account? '),
                
                TextButton(onPressed: (){
                  MyLog.debug('Signup button pressed');
                }, child: 
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xfe21B3EC),
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
