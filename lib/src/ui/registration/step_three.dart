import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
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
  final paddingHeigh = 20.0;

  @override
  void initState() {
    _initalValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20, right: 20),
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
      margin: EdgeInsets.only(top: 50),
      child: TextWidget(
        txt: contConfirmUserInfo,
        txtSize: 12,
        fontFamily: 'SF-Semibold',
      ),
    );
  }

  Widget _titleInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: TextWidget(txt: titleNoCard),
          padding: EdgeInsets.only(bottom: paddingHeigh),
        ),
        Container(
          child: TextWidget(txt: titleDOB),
          padding: EdgeInsets.only(bottom: paddingHeigh),
        ),
        Container(
          child: TextWidget(txt: titleName),
          padding: EdgeInsets.only(bottom: paddingHeigh),
        ),
        Container(
          child: TextWidget(txt: titleNoHp),
          padding: EdgeInsets.only(bottom: paddingHeigh),
        ),
        Container(child: TextWidget(txt: titleEmail)),
      ],
    );
  }

  Widget _valueInformation(vCardNo, vTglLahir, vName, vNoHp, vEmail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: paddingHeigh),
          child: TextWidget(
            txt: vCardNo,
            color: blueStandart,
            fontFamily: 'SF-Semibold',
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: paddingHeigh),
          child: TextWidget(
            txt: vTglLahir,
            color: blueStandart,
            fontFamily: 'SF-Semibold',
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: paddingHeigh),
          child: TextWidget(
            txt: vName,
            color: blueStandart,
            fontFamily: 'SF-Semibold',
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: paddingHeigh),
              child: TextWidget(
                txt: vNoHp,
                color: blueStandart,
                fontFamily: 'SF-Semibold',
              ),
            ),
          ],
        ),
        Container(
          child: TextWidget(
            txt: vEmail,
            color: blueStandart,
            fontFamily: 'SF-Semibold',
          ),
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
      setState(() {
        _name = doRegistrationModel.data.name;
      });
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
      _birthDate = formatDate(_year + _month + _day, "dd-MMM-yyyy");
    });

    SharedPreferencesHelper.getPhone().then((value) {
      _phone = value;
    });

    SharedPreferencesHelper.getEmail().then((value) {
      _email = value;
    });
  }
}
