import 'package:clg_chat/features/group_chat/presentation/pages/group_chat_page.dart';
import 'package:clg_chat/features/lost_and_found/presentation/pages/lost_and_found_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clg_chat/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:clg_chat/features/chat/presentation/pages/chat_page.dart';
import 'package:clg_chat/features/global_chat/presentation/pages/global_chat_page.dart';
import 'package:clg_chat/features/profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ChatPage(),
    GlobalChatPage(),
    GroupsPage(),
    LostFoundPage(),
    ProfilePage(),
  ];

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  void _logout() {
    context.read<AuthCubit>().logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xfe21B3EC),
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Global',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            label: 'Lost & Found',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
