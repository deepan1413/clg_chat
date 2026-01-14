import 'package:flutter/material.dart';

class GlobalChatPage extends StatelessWidget {
  const GlobalChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Global Chat',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
