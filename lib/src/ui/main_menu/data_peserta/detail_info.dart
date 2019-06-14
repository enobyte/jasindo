import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/ImageCircle.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class DetailInfoPeserta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailInfoPesertaState();
  }
}

class DetailInfoPesertaState extends State<DetailInfoPeserta> {
  String _noCard,
      _corporate,
      _level,
      _typeMember,
      _policy,
      _dateBirth,
      _benefit,
      _polisPeriod,
      _name;

  @override
  void initState() {
    _initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false, //disable back button
          backgroundColor: Colors.transparent,
          expandedHeight: MediaQuery.of(context).size.height / 3,
          flexibleSpace: FlexibleSpaceBar(background: _header()),
        ),
        SliverFixedExtentList(
          itemExtent: 30.0,
          delegate: SliverChildListDelegate(
            [
              Divider(
                color: Colors.transparent,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Perusahaan', color: Colors.blue),
                    TextWidget(txt: _corporate)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Level', color: Colors.blue),
                    TextWidget(txt: _level)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'No Kartu', color: Colors.blue),
                    TextWidget(txt: _noCard)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Tipe Peserta', color: Colors.blue),
                    TextWidget(txt: _typeMember)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Policy', color: Colors.blue),
                    TextWidget(txt: _policy)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Tanggal Lahir', color: Colors.blue),
                    TextWidget(txt: _dateBirth)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Manfaat', color: Colors.blue),
                    TextWidget(txt: _benefit)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Periode Polis', color: Colors.blue),
                    TextWidget(txt: _polisPeriod)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Stack(fit: StackFit.expand, children: <Widget>[
      Image.network(
          'https://0.s3.envato.com/files/79885804/Crystal-Faces-Background-preview.jpg',
          fit: BoxFit.cover),
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 5),
            ImageCircle(
                true,
                'https://static.stayjapan.com/assets/user_no_photo-4896a2d64d70a002deec3046d0b6ea6e7f01628781493566c95a02361524af97.png',
                80),
            Spacer(flex: 1),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: TextWidget(
                    txt: _name,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.stars,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Spacer(flex: 1),
            FlatButton.icon(
              color: Colors.blue,
              onPressed: () => {},
              icon: Icon(
                Icons.wc,
                color: Colors.white,
              ),
              label: TextWidget(
                txt: 'Akun Keluarga',
                color: Colors.white,
              ),
            ),
            Spacer(flex: 5),
          ],
        ),
      )
    ]);
  }

  _initView() {
    SharedPreferencesHelper.getDoLogin().then((onValue) {
      final memberModels = MemberModels.fromJson(json.decode(onValue));
      setState(() {
        _name = memberModels.data.name;
        _noCard = memberModels.data.cardNumb;
        _corporate = memberModels.adcps.corporateInfo;
        _level = "";
        _typeMember = memberModels.adcps.memberType;
        _policy = memberModels.adcps.payorInfo;
        _dateBirth = memberModels.data.birthDate;
        _benefit = "";
        _polisPeriod = "";
      });
    });
  }
}
