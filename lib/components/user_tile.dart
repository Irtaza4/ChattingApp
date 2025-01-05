import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  String text;
  final void Function()? onTap;
   UserTile({super.key, required this.text,required this.onTap} );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),


        ),
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 20,),
            Text(text),
          ],
        ),
      ),
    );
  }
}
