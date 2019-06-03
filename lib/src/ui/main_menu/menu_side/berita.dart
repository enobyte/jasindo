import 'package:flutter/material.dart';
import 'package:jasindo_app/widgets/ImageCover.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class News extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsState();
  }
}

class NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => _pageNews(),
          itemCount: 10,
        ),
      ),
    );
  }

  Widget _pageNews() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            ImageCover(true,
                'https://images.pexels.com/photos/417173/pexels-photo-417173.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
            Container(
              margin: EdgeInsets.only(bottom: 30, left: 10),
              alignment: FractionalOffset.bottomLeft,
              child: TextWidget(
                color: Colors.white,
                txt: 'Jasindo Travel Assurance',
              ),
            )
          ],
        ),
      ),
    );
  }
}
