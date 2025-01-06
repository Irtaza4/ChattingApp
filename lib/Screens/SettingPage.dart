import 'package:chattingapp/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settingpage extends StatelessWidget {
  const Settingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:Theme.of(context).colorScheme.primary ,
      ),
      body: Container(
        decoration:BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dark theme
            Text("Dark Mode"),
            //switch toggle
            CupertinoSwitch(value: Provider.of<ThemeProvider>(context,listen: false)
                .isDarkMode,
                onChanged: (value)=>Provider.of<ThemeProvider>(context,listen: false)
                    .toggleTheme(),)
          ],
        ),
      ),
    );
  }
}
