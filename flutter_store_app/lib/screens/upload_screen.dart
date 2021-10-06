import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  static const routeName = '/upload';
  const UploadScreen({ Key? key }) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Upload'),
      
    );
  }
}