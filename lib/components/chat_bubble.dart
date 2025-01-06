import 'package:chattingapp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({super.key,required this.message,required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    bool isDarkmode =Provider.of<ThemeProvider>(context,listen: false).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color:  isCurrentUser
            ? (isDarkmode? Colors.green.shade600:Colors.green.shade500)
            : (isDarkmode? Colors.grey.shade800:Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
      child: Text(message,
      style: TextStyle(
        color: isCurrentUser
            ? Colors.white:
        (isDarkmode? Colors.white:
        Colors.black)),
      ),
    );
  }
}
