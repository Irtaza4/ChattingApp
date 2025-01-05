import 'package:chattingapp/Screens/SettingPage.dart';

import 'package:flutter/material.dart';

import '../Services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
void logout(){
  final _auth = AuthService();
  _auth.signOut();
}

  @override
  Widget build(BuildContext context) {
    return  Drawer(
    backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            //logo
            DrawerHeader
              (decoration:null,
                child: Center(child:
                Icon(Icons.message,color:Theme.of(context).colorScheme.primary ,
                  size: 40,)
                  ,)),

            //home lsit tile
            Padding(
              padding: const EdgeInsets.only(left:25),
              child: ListTile(
                title: Text("H O M E"),
                leading: Icon(Icons.home),
                onTap: (){
                Navigator.pop(context);
                },
              ),
            ),

            //setting list tile
            Padding(
              padding: const EdgeInsets.only(left:25),
              child: ListTile(
                title: Text("S E T T I N G S"),
                leading: Icon(Icons.settings),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Settingpage()));
                },
              ),
            ),
          ],),
          //logout tile
          Padding(
            padding: const EdgeInsets.only(left:25),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap: (){
                logout();
              },
            ),
          ),
        ],
      ),
    );

  }
}
