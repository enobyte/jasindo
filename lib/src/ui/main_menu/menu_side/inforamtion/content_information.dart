import 'package:flutter/material.dart';

class ContentInformation extends StatefulWidget {
  String imageUrl;

  @override
  State<StatefulWidget> createState() {
    return ContentInformationState();
  }

  ContentInformation({this.imageUrl});
}

class ContentInformationState extends State<ContentInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Informasi", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Image.asset(widget.imageUrl),
      ),
    );
  }
}
