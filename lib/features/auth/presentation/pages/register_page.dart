import 'package:clg_chat/components/mybutton.dart';
import 'package:clg_chat/components/mytextfield.dart';
import 'package:clg_chat/mylogs/mylogs.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              child: MyButton(name: "Register", ontap: () {}),
            ),
          
          ],
        ),
      ),
    );
  }
}
