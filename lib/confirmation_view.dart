import 'package:flutter/material.dart';

class ConfirmationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.lightGreen,
            size: 96,
          ),
          Text(
            "Success",
            style: TextStyle(fontSize: 48, color: Colors.white),
          )
        ],
      ),
    );
  }
}
