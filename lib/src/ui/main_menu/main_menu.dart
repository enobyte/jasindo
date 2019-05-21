import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/ui/main_menu/data_peserta/data_peserta.dart';
import 'package:jasindo_app/src/ui/main_menu/riwayat_klaim.dart';
import 'package:jasindo_app/src/ui/main_menu/side_menu.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ImageSlider/Carousel.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';
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
  Widget _contentPage;

  @override
  void didChangeDependencies() {
    _contentPage = _scaleWidget();
    super.didChangeDependencies();
  }

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
                  attachContent(index),
                }),
        contentScreen: Layout(
            contentBuilder: (context) => Container(
                  color: Colors.white,
                  child: _contentPage,
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
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Carousel(
              overlayShadow: true,
              overlayShadowColors: Colors.white,
              overlayShadowSize: 0.7,
              animationDuration: Duration(days: 1),
              dotBgColor: Colors.transparent,
              boxFit: BoxFit.cover,
              images: [
                new NetworkImage(
                    'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                new NetworkImage(
                    'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
              ],
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height / 6,
              bottom: MediaQuery.of(context).size.height / 8,
              right: MediaQuery.of(context).size.width / 3,
              child: Container(
                //color: Colors.blue,
                padding: EdgeInsets.only(left: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      txt: 'BUMN Hadir Untuk Negeri',
                      color: Colors.white,
                      txtSize: 30,
                      align: TextAlign.start,
                    ),
                    TextWidget(
                      txt: 'BUMN Hadir Untuk Negeri',
                      color: Colors.white,
                      txtSize: 12,
                      align: TextAlign.start,
                    ),
                    RaisedButton(
                      child: TextWidget(
                        txt: 'CARI TAHU',
                        color: Colors.white,
                      ),
                      //color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
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
                    child: InkWell(
                      onTap: () => {
                            routeToWidget(
                              context,
                              new DataPeserta(),
                            )
                          },
                      child: Container(child: menuItems('Data Peserta')),
                    ),
                  )),
                  Flexible(
                      child: Card(
                    elevation: 4,
                    child: Container(child: menuItems('Provider Rekanan')),
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
                    child: InkWell(
                      child: Container(
                        child: menuItems('Riwayat Klaim'),
                      ),
                      onTap: () => {routeToWidget(context, new RiwayatKlaim())},
                    ),
                  )),
                  Flexible(
                      child: Card(
                    elevation: 4,
                    child: Container(child: menuItems('Hubungi Call Center')),
                  )),
                ]),
          ),
        ]),
      ),
    );
  }

  Widget attachContent(int index) {
    switch (index) {
      case 0:
        _contentPage = _scaleWidget();
        break;
      case 1:
        _contentPage = Container();
        break;
      default:
        _contentPage = _scaleWidget();
        break;
    }
    return _contentPage;
  }

  Widget menuItems(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(flex: 5),
        Icon(Icons.print),
        Spacer(flex: 2),
        Text(title),
        Spacer(flex: 5),
      ],
    );
  }
}
