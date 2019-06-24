import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ImageCover.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class DetailNews extends StatefulWidget {
  String title, content, date, image;

  @override
  State<StatefulWidget> createState() {
    return DetailNewsState();
  }

  DetailNews({this.title, this.content, this.date, this.image});
}

class DetailNewsState extends State<DetailNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: TextWidget(txt: "Berita", color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false, //disable back button
            backgroundColor: Colors.transparent,
            expandedHeight: MediaQuery.of(context).size.height / 2,
            flexibleSpace: FlexibleSpaceBar(background: _header()),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextWidget(
                        txt:
                            formatDateFormStandart(widget.date, "dd MMMM yyyy"),
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextWidget(
                        txt: widget.title,
                        txtSize: 25,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Html(
                        data: widget.content,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _header() {
    return Image.network(widget.image, fit: BoxFit.fill,);
  }
}
