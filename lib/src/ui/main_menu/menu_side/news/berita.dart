import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/news_bloc.dart';
import 'package:jasindo_app/src/models/news_model.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ImageCover.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

import 'detail_berita.dart';

class News extends StatefulWidget {
  NewsBloc bloc;

  @override
  State<StatefulWidget> createState() {
    return NewsState();
  }
  News(this.bloc);
}

class NewsState extends State<News> {
  @override
  void initState() {
    super.initState();
    widget.bloc.newsBloc((model) => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: widget.bloc.getNewsBloc,
          builder: (context, AsyncSnapshot<NewsModel> snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      _pageNews(snapshot, index),
                  itemCount: snapshot.data.data.length,
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _pageNews(AsyncSnapshot<NewsModel> snapshot, int index) {
    return InkWell(
      onTap: () => {
        routeToWidget(
            context,
            DetailNews(
              content: snapshot.data.data[index].content,
              title: snapshot.data.data[index].title,
              image: snapshot.data.data[index].images,
              date: snapshot.data.data[index].createat,
            ))
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  decoration: new BoxDecoration(
                    color: Colors.purple,
                    gradient: new LinearGradient(
                      colors: [Colors.brown, Colors.transparent],
                    ),
                  ),
                  child: Image.network(
                    snapshot.data.data[index].images,
                    fit: BoxFit.cover,
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 30, left: 20),
                alignment: FractionalOffset.bottomLeft,
                child: TextWidget(
                  color: Colors.white,
                  txtSize: 21,
                  txt: snapshot.data.data[index].title,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
