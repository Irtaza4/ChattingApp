import 'package:chattingapp/components/Models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService{
//get instance of firestore
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

//get user steam
Stream<List<Map<String,dynamic>>>getUserStream(){
  return _firestore.collection("Users").snapshots().map((snapshot) {

  return snapshot.docs.map((doc){
    final user=doc.data();
    return user;
  }).toList();
  });
}

//send message
Future<void> sendMessage(String receiveId,message)async{
//get current user info
final String currenUserId = _auth.currentUser!.uid;
final String curentUserEmail = _auth.currentUser!.email!;
final Timestamp timestamp = Timestamp.now();
//create a new message
Messages newMessage = Messages(
    senderId: curentUserEmail,
    senderEmail: currenUserId,
    receiverId: receiveId,
    message: message, timestamp: timestamp);
//construct chat room ids for two users
List<String> ids = [currenUserId,receiveId];
ids.sort();
String chatRoomId = ids.join('_');
//add new messagees to db
await _firestore.collection("chat_rooms").doc(chatRoomId).collection("messages").
add(newMessage.toMap());
}

//get messages
Stream<QuerySnapshot> getMessages(String userID, otherUserID){
  List<String> ids = [userID, otherUserID];
  ids.sort();
  String chatRoomID = ids.join('_');

  return _firestore.collection("chat_rooms").doc(chatRoomID).
  collection("messages").orderBy("timestamp",descending: false).snapshots();
}

}