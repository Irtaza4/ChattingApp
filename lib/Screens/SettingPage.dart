import 'package:flutter/material.dart';

class Settingpage extends StatelessWidget {
  const Settingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,),
    );
  }
}
