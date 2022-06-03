import 'package:flutter/material.dart';

bool isValidEmail(String email) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

void showMessage(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          content: Text(message ,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:const Text('OK',
                  style:  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ))
          ],
        );
      });
}

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          content: Row(
            children: const [
              CircularProgressIndicator(color: Colors.white,),
              SizedBox(
                width: 12,
              ),
               Text('Loading...',
                 style: TextStyle(
                     color: Colors.white,
                     fontWeight: FontWeight.bold,
                     fontSize: 18
                 ),
               )
            ],
          ),
        );
      },
      barrierDismissible: false);
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

