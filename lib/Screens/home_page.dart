import 'package:chattingapp/Screens/chat_page.dart';
import 'package:chattingapp/Services/chat/chat_service.dart';
import 'package:chattingapp/components/my_drawer.dart';
import '../Services/auth/auth_service.dart';

import 'package:flutter/material.dart';

import '../components/user_tile.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  // Chat & auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // Build individual user tile
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if(userData["email"]!= _authService.CurrentUser()!.email){
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receivedemail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    }
    else{
      return Container();
    }
  }
}
