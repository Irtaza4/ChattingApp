import 'package:chattingapp/Services/auth/auth_service.dart';
import 'package:chattingapp/Services/chat/chat_service.dart';
import 'package:chattingapp/components/chat_bubble.dart';
import 'package:chattingapp/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receivedemail;
  final String receiverID;

  ChatPage({super.key, required this.receivedemail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode.addListener((){
      if(myFocusNode.hasFocus){
        
        Future.delayed(Duration(milliseconds: 500),()=>scrollDown(),);
      }
    });
    Future.delayed(Duration(milliseconds: 500),()=>scrollDown(),);
  }
  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();

  }
  final ScrollController _scrollController= ScrollController();
  void scrollDown(){
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void sendMessages() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.receivedemail),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:Theme.of(context).colorScheme.primary ,
      ),
      body: Column(
        children: [
          // Display all the messages
          Expanded(
            child: _buildMessageList(),
          ),
          // Display user input at the bottom
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.CurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error loading messages."));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser =data['senderId'] == _authService.CurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

     return Container(
         alignment: alignment,
         child: Column(
           crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end : CrossAxisAlignment.start,
           children: [
             ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
           ],
         ));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              hinttext: "Type a message",
              obsecureText: false,
              controller: _messageController,
              focusNode: myFocusNode,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessages,
              icon: const Icon(Icons.send,
              color: Colors.white,),

            ),
          ),
        ],
      ),
    );
  }
}
