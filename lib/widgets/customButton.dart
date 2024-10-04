 import 'package:flutter/material.dart';

Widget buildButton(
    BuildContext context,
    String title,
    IconData icon,
    Widget page,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        icon: Icon(icon,color: Colors.black,),
        label: Text(title,style: TextStyle(color: Colors.black),),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          backgroundColor: Colors.blueAccent, // Use backgroundColor instead of primary
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }