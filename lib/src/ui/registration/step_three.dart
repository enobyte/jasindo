import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class StepThree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StepThreeState();
  }
}

class StepThreeState extends State<StepThree> {
  DoRegistrationModel doRegistrationModel;

  String _email;
  String _day;
  String _month;
  String _year;
  String _name;
  String _phone;
  String _cardNumber;
  String _birthDate;

  @override
  void initState() {
    super.initState();
    _initalValue();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 30.0),
        child: Column(
          children: <Widget>[
            _viewInformation(_cardNumber, _birthDate, _name, _phone, _email),
            _confirmation()
          ],
        ),
      ),
    );
  }

  Widget _confirmation() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TextWidget(
        txt: contConfirmUserInfo,
        txtSize: 12,
      ),
    );
  }

  Widget _titleInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(txt: titleNoCard),
        TextWidget(txt: titleDOB),
        TextWidget(txt: titleName),
        TextWidget(txt: titleNoHp),
        TextWidget(txt: titleEmail),
      ],
    );
  }

  Widget _valueInformation(vCardNo, vTglLahir, vName, vNoHp, vEmail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(
          txt: vCardNo,
          color: Colors.blue,
        ),
        TextWidget(
          txt: vTglLahir,
          color: Colors.blue,
        ),
        TextWidget(
          txt: vName,
          color: Colors.blue,
        ),
        TextWidget(
          txt: vNoHp,
          color: Colors.blue,
        ),
        TextWidget(
          txt: vEmail,
          color: Colors.blue,
        )
      ],
    );
  }

  Widget _viewInformation(vCardNo, vTglLahir, vName, vNoHp, vEmail) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),
          _titleInformation(),
          SizedBox(width: 10),
          _valueInformation(vCardNo, vTglLahir, vName, vNoHp, vEmail)
        ],
      ),
    );
  }

  _initalValue() {
    SharedPreferencesHelper.getDoRegistration().then((onValue) {
      doRegistrationModel = DoRegistrationModel.fromJson(json.decode(onValue));
      _name = doRegistrationModel.data.name;
    });

    SharedPreferencesHelper.getCardNumb().then((card) {
      _cardNumber = card;
    });

    SharedPreferencesHelper.getDay().then((days) {
      _day = days;
      _birthDate = _day;
    });

    SharedPreferencesHelper.getMonth().then((month) {
      _month = month;
      _birthDate = _day + ' ' + _month;
    });

    SharedPreferencesHelper.getYear().then((year) {
      _year = year;
      _birthDate = _day + ' ' + _month + ' ' + _year;
    });

    SharedPreferencesHelper.getPhone().then((value) {
      _phone = value;
    });

    SharedPreferencesHelper.getEmail().then((value) {
      _email = value;
    });
  }
}
