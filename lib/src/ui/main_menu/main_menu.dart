import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/about_bloc.dart';
import 'package:jasindo_app/src/blocs/news_bloc.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/news_model.dart';
import 'package:jasindo_app/src/ui/main_menu/data_peserta/data_peserta.dart';
import 'package:jasindo_app/src/ui/main_menu/menu_side/inforamtion/informasi.dart';
import 'package:jasindo_app/src/ui/main_menu/menu_side/news/berita.dart';
import 'package:jasindo_app/src/ui/main_menu/provider/provider_rekanan.dart';
import 'package:jasindo_app/src/ui/main_menu/riwayat_klaim.dart';
import 'package:jasindo_app/src/ui/main_menu/side_menu.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ImageSlider/Carousel.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';
import 'package:jasindo_app/widgets/ZoomScaffold.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'package:jasindo_app/src/ui/main_menu/menu_side/settings/pengaturan.dart';
import 'menu_side/news/detail_berita.dart';
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
  bool isFirst = true;
  String _name, _callCenter;
  final _blocNews = NewsBloc();
  final _blocNewsData = NewsBloc();
  final _blocAbout = AboutBloc();
  NewsModel modelNews;
  int indexSlide = 0;

  @override
  void initState() {
    super.initState();
    _initView();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    changeSlide.close();
    _blocNewsData.dispose();
    _blocNews.dispose();
    super.dispose();
  }

  getDataNews(NewsModel model) {
    setState(() {
      this.modelNews = model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomScaffold(
        menuScreen: SideMenu(
          onClick: (index) => {
                attachContent(index),
                changeSlide.sink.add(titleAppbar),
              },
          name: _name,
        ),
        contentScreen: Layout(
            contentBuilder: (context) => Container(
                  color: Colors.white,
                  child: isFirst ? _scaleWidget() : _contentPage,
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
            onImageChange: (index, data) => {
                  _setImageSlide(index),
                },
            overlayShadow: true,
            overlayShadowColors: Colors.white,
            overlayShadowSize: 0.7,
            animationDuration: Duration(days: 1),
            dotBgColor: Colors.transparent,
            boxFit: BoxFit.cover,
            images: [
              new NetworkImage(
                  modelNews != null ? modelNews.data[0].images : "http://"),
              new NetworkImage(
                  modelNews != null ? modelNews.data[1].images : "http://"),
            ],
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height / 10,
            bottom: MediaQuery.of(context).size.height / 8,
            right: MediaQuery.of(context).size.width / 3,
            child: Container(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextWidget(
                    txt: modelNews != null
                        ? modelNews.data[indexSlide].title
                        : "",
                    color: Colors.white,
                    txtSize: 30,
                    align: TextAlign.start,
                  ),
                  TextWidget(
                    txt: modelNews != null
                        ? modelNews.data[indexSlide].title
                        : "",
                    color: Colors.white,
                    txtSize: 12,
                    align: TextAlign.start,
                  ),
                  RaisedButton(
                    onPressed: () => {
                          routeToWidget(
                              context,
                              DetailNews(
                                title: modelNews.data[indexSlide].title,
                                content: modelNews.data[indexSlide].content,
                                image: modelNews.data[indexSlide].images,
                                date: modelNews.data[indexSlide].createat,
                              ))
                        },
                    child: TextWidget(
                      txt: 'CARI TAHU',
                      color: Colors.white,
                    ),
                    color: orangeColor2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuBox() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(30),
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
                        child: Container(
                            child: menuItems('Data Peserta',
                                'lib/assets/images/ic_peserta.png')),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () =>
                            {routeToWidget(context, new ProviderRekanan())},
                        child: Container(
                          child: menuItems('Provider Rekanan',
                              'lib/assets/images/ic_provider.png'),
                        ),
                      ),
                    ),
                  ),
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
                          child: menuItems('Riwayat Klaim',
                              'lib/assets/images/ic_riwayatclaim.png'),
                        ),
                        onTap: () =>
                            {routeToWidget(context, new RiwayatKlaim())},
                      ),
                    ),
                  ),
                  Flexible(
                    child: Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () => {_makeCall()},
                        child: Container(
                            child: menuItems('Hubungi Call Center',
                                'lib/assets/images/ic_callcenter.png')),
                      ),
                    ),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }

  Widget attachContent(int index) {
    setState(() {
      isFirst = false;
    });
    switch (index) {
      case 0:
        _setTitle('');
        _contentPage = _scaleWidget();
        break;
      case 1:
        _setTitle('Buku Panduan');
        _launchBukuPanduan(
            'https://jasindo.co.id/uploads/cms_laporan_tahunan/Annual%20Report%20Jasindo%202016_Latest.pdf');
        _contentPage = Container();
        break;
      case 2:
        _setTitle('Berita');
        _contentPage = News(_blocNews);
        break;
      case 3:
        _setTitle('Informasi');
        _contentPage = Information();
        break;
      case 4:
        _setTitle('Tentang Kami');
        _contentPage = About(_blocAbout);
        break;
      case 5:
        _setTitle('Pengaturan');
        _contentPage = Setting(_blocAbout);
        break;
      default:
        _setTitle('');
        _contentPage = _scaleWidget();
        break;
    }
    return _contentPage;
  }

  Widget menuItems(String title, String image) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Expanded(
          child: Image.asset(image, alignment: Alignment.center),
        ),
        SizedBox(height: 10),
        TextWidget(
          txt: title,
          fontFamily: 'SF-Semibold',
        ),
        SizedBox(height: 10)
      ],
    );
  }

  void _setTitle(title) {
    setState(() {
      this.titleAppbar = title;
    });
  }

  _initView() {
    SharedPreferencesHelper.getDoLogin().then((onValue) {
      final memberModels = MemberModels.fromJson(json.decode(onValue));
      setState(() {
        _name = memberModels.data.name;
        _callCenter = memberModels.adcps.helpLine;
      });
      _blocNewsData.newsBloc((model) => {
            getDataNews(model),
          });
    });
  }

  Future<void> _makeCall() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(_callCenter),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Call'),
              onPressed: () {
                UrlLauncher.launch("tel://" + _callCenter);
              },
            ),
          ],
        );
      },
    );
  }

  _launchBukuPanduan(String url) async {
    if (await UrlLauncher.canLaunch(url)) {
      await UrlLauncher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _setImageSlide(int index) {
    if (index == 0) {
      index = 1;
    } else if (index == 1) {
      index = 0;
    }
    setState(() {
      indexSlide = index;
    });
  }
}
