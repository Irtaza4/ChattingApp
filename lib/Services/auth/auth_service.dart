import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{
  //instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //currentUSer
  User? CurrentUser(){
    return _auth.currentUser;
  }
  //sign in
Future<UserCredential> signinWithEmailAndPassword(String email, String password)
async{
  try{
    UserCredential userCredential =await _auth.signInWithEmailAndPassword
      (email: email, password: password);
    _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email':email
        }
    );
    return userCredential;
  }
  on FirebaseAuthException catch(e){
    throw Exception(e.code);
  }

}
  //sign up
 Future<UserCredential> SignupWithUserAndPassword (String email, String password)async{
  try{
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email,
        password: password);
    _firestore.collection("Users").doc(userCredential.user!.uid).set(
      {
        'uid': userCredential.user!.uid,
        'email':email
      }
    );
    return userCredential;
  }
  on FirebaseAuthException catch(e){
    throw Exception(e.code);
  }
 }

  //sign out
Future<void> signOut()async{
  return await _auth.signOut();
}

  //errors


}