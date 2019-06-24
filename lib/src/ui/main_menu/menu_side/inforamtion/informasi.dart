import 'package:flutter/material.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

import 'content_information.dart';

class Information extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InformationState();
  }
}

class InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      body: Container(
        child: Column(
          children: <Widget>[
            _titleInformation(),
            _listOne(),
            _listTwo(),
            _listThree(),
            _listFour(),
            _listFive(),
          ],
        ),
      ),
    );
  }

  Widget _titleInformation() {
    return Container(
      padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
      width: double.infinity,
      child: TextWidget(
        txt: 'Prosedur Pelayanan Kesehatan',
        txtSize: 18,
        fontFamily: 'SF-Bold',
        color: blueStandart,
        align: TextAlign.left,
      ),
    );
  }

  Widget _listOne() {
    return InkWell(
      onTap: () => {
            routeToWidget(context,
                ContentInformation(imageUrl: 'lib/assets/images/ri_show.png'))
          },
      child: Container(
        padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
        margin: EdgeInsets.only(top: 1, bottom: 1),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 1, color: Colors.grey),
              right: BorderSide(width: 1, color: Colors.grey),
            ),
            color: Colors.white),
        child: Row(
          children: <Widget>[
            TextWidget(
              txt: 'Rawat Inap & Persalinan Provider : ',
              align: TextAlign.left,
            ),
            TextWidget(
              txt: 'ShowCard',
              fontFamily: 'SF-Black',
              align: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTwo() {
    return InkWell(
      onTap: () => {
        routeToWidget(context,
            ContentInformation(imageUrl: 'lib/assets/images/rj_show.png'))
      },
      child: Container(
        padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
        margin: EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 1, color: Colors.grey),
              right: BorderSide(width: 1, color: Colors.grey),
            ),
            color: Colors.white),
        child: Row(
          children: <Widget>[
            TextWidget(
              txt: 'Rawat Jalan, Gigi & Kacamata Provider : ',
              align: TextAlign.left,
            ),
            TextWidget(
              txt: 'ShowCard',
              fontFamily: 'SF-Black',
              align: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listThree() {
    return InkWell(
      onTap: () => {
            routeToWidget(context,
                ContentInformation(imageUrl: 'lib/assets/images/ri_swipe.png'))
          },
      child: Container(
        padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
        margin: EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 1, color: Colors.grey),
              right: BorderSide(width: 1, color: Colors.grey),
            ),
            color: Colors.white),
        child: Row(
          children: <Widget>[
            TextWidget(
              txt: 'Rawat Inap & Persalinan Provider : ',
              align: TextAlign.left,
            ),
            TextWidget(
              txt: 'SwipeCard',
              fontFamily: 'SF-Black',
              align: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listFour() {
    return InkWell(
      onTap: () => {
            routeToWidget(context,
                ContentInformation(imageUrl: 'lib/assets/images/rj_swipe.png'))
          },
      child: Container(
        padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
        margin: EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 1, color: Colors.grey),
              right: BorderSide(width: 1, color: Colors.grey),
            ),
            color: Colors.white),
        child: Row(
          children: <Widget>[
            TextWidget(
              txt: 'Rawat Jalan, Gigi & Kacamata Provider : ',
              align: TextAlign.left,
            ),
            TextWidget(
              txt: 'SwipeCard',
              fontFamily: 'SF-Black',
              align: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listFive() {
    return InkWell(
      onTap: () => {
            routeToWidget(
                context,
                ContentInformation(
                    imageUrl: 'lib/assets/images/non_provider.png'))
          },
      child: Container(
        padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
        margin: EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 1, color: Colors.grey),
              right: BorderSide(width: 1, color: Colors.grey),
            ),
            color: Colors.white),
        child: Row(
          children: <Widget>[
            TextWidget(
              txt: 'Reimbursment',
              align: TextAlign.left,
            ),
            TextWidget(
              txt: '(Non Provider)',
              align: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
