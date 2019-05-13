import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainMenuState();
  }
}

class MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: Icon(Icons.print),
        actions: <Widget>[Icon(Icons.remove_red_eye), SizedBox(width: 10)],
      ),
      body: _scaleWidget(),
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
