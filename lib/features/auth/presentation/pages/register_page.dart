import 'package:clg_chat/components/my_button.dart';
import 'package:clg_chat/components/my_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
   void Function()? onPressed;

   RegisterPage({super.key, required this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            MyTextfield(label: 'Name'),
            MyTextfield(label: 'Email'),
            MyTextfield(label: 'password'),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: MyButton(name: "Register", ontap: () {}),
            ),
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: .end,
                children: [
                  Text('don\'t have account? '),
                
                TextButton(onPressed:widget.onPressed , child: 
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