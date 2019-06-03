import 'package:flutter/material.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

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
        align: TextAlign.left,
      ),
    );
  }

  Widget _listOne() {
    return Container(
      padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
      margin: EdgeInsets.only(top: 1,  bottom: 1),
      decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 1, color: Colors.grey),
            right: BorderSide(width: 1, color: Colors.grey),
          ),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          TextWidget(
            txt: 'Rawat Inap & Persalinan Provider',
            align: TextAlign.left,
          ),
          TextWidget(
            txt: ': ShowCard',
            align: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _listTwo() {
    return Container(
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
            txt: 'Rawat Inap & Persalinan Provider',
            align: TextAlign.left,
          ),
          TextWidget(
            txt: ': ShowCard',
            align: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _listThree() {
    return Container(
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
            txt: 'Rawat Inap & Persalinan Provider',
            align: TextAlign.left,
          ),
          TextWidget(
            txt: ': ShowCard',
            align: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _listFour() {
    return Container(
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
            txt: 'Rawat Inap & Persalinan Provider',
            align: TextAlign.left,
          ),
          TextWidget(
            txt: ': ShowCard',
            align: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _listFive() {
    return Container(
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
            txt: 'Rawat Inap & Persalinan Provider',
            align: TextAlign.left,
          ),
          TextWidget(
            txt: ': ShowCard',
            align: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
