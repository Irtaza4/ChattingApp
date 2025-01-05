import 'package:chattingapp/Screens/login.dart';
import 'package:chattingapp/Screens/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}


class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;
  void togglePage(){
  setState(() {
    showLoginPage =!showLoginPage;
  });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return Login(
        onTap: togglePage,
      );

    }
    else{
      return Register(
          onTap: togglePage,
      );
    }
  }
}
