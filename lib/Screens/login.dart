
import 'package:chattingapp/components/my_button.dart';
import 'package:chattingapp/components/my_textfield.dart';
import 'package:flutter/material.dart';

import '../Services/auth/auth_service.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final void Function()? onTap;
   Login({super.key,required this.onTap});
   void login(BuildContext context)async{
     final authService = AuthService();

     try{
       await authService.signinWithEmailAndPassword(_emailcontroller.text,
           _passwordcontroller.text);
     }
  catch(e){
       showDialog(context: context, builder: (context)=>AlertDialog(
       title: Text(e.toString()),
       ),
       );
  }
   }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            //logo
            Icon(Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 50,),
            Text("Welcome back,you've been missed!",style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16
            ),),
            SizedBox(height: 25,),
            MyTextfield(
              hinttext: "Email",
              obsecureText: false,
              controller: _emailcontroller
            ),
            SizedBox(height: 10,),
            MyTextfield(
              hinttext: "Password",
              obsecureText: true,
              controller: _passwordcontroller,
            ),
            SizedBox(height: 25,),
            MyButton(text: "Login",
            onTap: ()=> login(context),
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member?',style: TextStyle(
              
              color: Theme.of(context).colorScheme.primary,
            ),),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: onTap,
                  child: Text('Register now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
