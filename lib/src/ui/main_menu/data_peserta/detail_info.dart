import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ImageCircle.dart';
import 'package:jasindo_app/widgets/ImageCover.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class DetailInfoPeserta extends StatefulWidget {
  List<String> benefit;
  String polisPeriod;

  @override
  State<StatefulWidget> createState() {
    return DetailInfoPesertaState();
  }

  DetailInfoPeserta({this.benefit, this.polisPeriod});
}

class DetailInfoPesertaState extends State<DetailInfoPeserta> {
  String _noCard, _corporate, _level, _typeMember, _policy, _dateBirth, _name;

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
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Divider(
                color: Colors.transparent,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
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
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Level', color: Colors.blue),
                    TextWidget(txt: _level == 'N' ? 'NON VIP' : 'VIP')
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    TextWidget(txt: 'Manfaat', color: Colors.blue),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: TextWidget(
                        align: TextAlign.right,
                        txt: widget.benefit.join(', '),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Periode Polis', color: Colors.blue),
                    TextWidget(txt: widget.polisPeriod)
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
      ImageCover(false, 'lib/assets/images/background_peserta.png'),
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
                    child: _level == 'Y'
                        ? Image.asset(
                            'lib/assets/images/ic_vip.png',
                            height: 20,
                          )
                        : Container())
              ],
            ),
            Spacer(flex: 1),
            FlatButton.icon(
              color: Colors.white,
              onPressed: () => {},
              icon: Image.asset(
                'lib/assets/images/ic_family.png',
                height: 15,
              ),
              label: TextWidget(
                txt: 'Akun Keluarga',
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
        _level = memberModels.adcps.vip;
        _typeMember = memberModels.adcps.memberType;
        _policy = memberModels.adcps.policyNumber.replaceAll(" ", "");
        _dateBirth =
            formatDateFormStandart(memberModels.data.birthDate, "dd MMMM yyyy");
      });
    });
  }
}
