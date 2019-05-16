import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/ui/main_menu/side_menu.dart';
import 'package:jasindo_app/widgets/ZoomScaffold.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainMenuState();
  }
}

class MainMenuState extends State<MainMenu> {
  // ignore: close_sinks
  final changeSlide = new StreamController.broadcast();

  @override
  void dispose() {
    changeSlide.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomScaffold(
        menuScreen: SideMenu(
            onClick: (index) => {
                  changeSlide.sink.add(null),
                  debugPrint(index.toString()),
                }),
        contentScreen: Layout(
            contentBuilder: (context) => Container(
                  color: Colors.white,
                  child: _scaleWidget(),
                )),
        actionTogle: changeSlide.stream,
      ),
    );
  }

  Widget _scaleWidget() {
    return Column(
      children: <Widget>[_imageSlide(), _menuBox()],
    );
  }

  Widget _imageSlide() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      color: Colors.red,
    );
  }

  Widget _menuBox() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(20),
        alignment: FractionalOffset.center,
        child: Row(children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                      child: Card(
                    elevation: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.print),
                          Text('Data Peserta')
                        ],
                      ),
                    ),
                  )),
                  Flexible(
                      child: Card(
                    elevation: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.print),
                          Text('Riwayat Klain')
                        ],
                      ),
                    ),
                  )),
                ]),
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                      child: Card(
                    elevation: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.print),
                          Text('Provider Rekanan')
                        ],
                      ),
                    ),
                  )),
                  Flexible(
                      child: Card(
                    elevation: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.print),
                          Text('Hubungi Call Center')
                        ],
                      ),
                    ),
                  )),
                ]),
          ),
        ]),
      ),
    );
  }
}
