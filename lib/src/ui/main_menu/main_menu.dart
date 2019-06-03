import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/ui/main_menu/data_peserta/data_peserta.dart';
import 'package:jasindo_app/src/ui/main_menu/menu_side/berita.dart';
import 'package:jasindo_app/src/ui/main_menu/menu_side/informasi.dart';
import 'package:jasindo_app/src/ui/main_menu/provider_rekanan.dart';
import 'package:jasindo_app/src/ui/main_menu/riwayat_klaim.dart';
import 'package:jasindo_app/src/ui/main_menu/side_menu.dart';
import 'package:jasindo_app/widgets/webview_form.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ImageSlider/Carousel.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';
import 'package:jasindo_app/widgets/ZoomScaffold.dart';

import 'menu_side/pengaturan.dart';
import 'menu_side/tentang.dart';

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
  var titleAppbar = '';

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
                  attachContent(index),
                  changeSlide.sink.add(titleAppbar),
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
                      onPressed: () => {},
                      child: TextWidget(
                        txt: 'CARI TAHU',
                        color: Colors.white,
                      ),
                      color: Colors.blue,
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
                    child: InkWell(
                        onTap: () =>
                            {routeToWidget(context, new ProviderRekanan())},
                        child: Container(child: menuItems('Provider Rekanan'))),
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
        _setTitle('');
        _contentPage = _scaleWidget();
        break;
      case 1:
        _setTitle('Buku Panduan');
        _contentPage = WebViewContainer('https://google.com');
        break;
      case 2:
        _setTitle('Berita');
        _contentPage = News();
        break;
      case 3:
        _setTitle('Informasi');
        _contentPage = Information();
        break;
      case 4:
        _setTitle('Tentang Kami');
        _contentPage = About();
        break;
      case 5:
        _setTitle('Pengaturan');
        _contentPage = Setting();
        break;
      default:
        _setTitle('Berita');
        _contentPage = News();
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

  void _setTitle(title) {
    setState(() {
      this.titleAppbar = title;
    });
  }
}
