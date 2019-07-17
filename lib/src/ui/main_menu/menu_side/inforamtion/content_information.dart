import 'package:flutter/material.dart';

class ContentInformation extends StatefulWidget {
  String imageUrl;
  bool isNetWork;

  @override
  State<StatefulWidget> createState() {
    return ContentInformationState();
  }

  ContentInformation({this.imageUrl, this.isNetWork});
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
        child: widget.isNetWork
            ? Image.network(widget.imageUrl)
            : Image.asset(widget.imageUrl),
      ),
    );
  }
}
