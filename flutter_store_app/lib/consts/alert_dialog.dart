import 'package:flutter/material.dart';

class ShowDialogs {
  Future<void> showAlertDialog(String title, String subTitle, Function function,
      BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.title),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(title),
              ),
            ],
          ),
          content: Text(subTitle),
          actions: [
            TextButton(
              onPressed: () {
                function();
                Navigator.pop(context);
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> authErrorHandler(String subtitle, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
             title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.title),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Error Occured'),
              ),
              
            ],
          ),
          content: Text(subtitle),
          actions: [
            TextButton(
              onPressed: () {
                
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
          

          );
        });
  }
}
