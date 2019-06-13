import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class StepTwo extends StatefulWidget {
  Function onChangeData;

  @override
  State<StatefulWidget> createState() {
    return StepTwoState();
  }

  StepTwo(this.onChangeData);
}

class StepTwoState extends State<StepTwo> {
  DoRegistrationModel doRegistrationModel;

  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _reEmailController = TextEditingController();

  String _name = "";

  @override
  void initState() {
    super.initState();

    _initialValue();

    _phoneController.addListener(onChangeData);
    _emailController.addListener(onChangeData);
    _reEmailController.addListener(onChangeData);
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _reEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 40.0, top: 30.0, right: 40),
        child: Column(
          children: <Widget>[
            Container(
              alignment: FractionalOffset.topLeft,
              child: TextWidget(
                txt: 'Nama',
              ),
            ),
            Container(
              child: TextWidget(
                txt: _name,
                txtSize: 24,
                color: Colors.blue,
                align: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: titleNoHp,
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)))),
                controller: _phoneController,
              ),
            ),
            Container(
              alignment: FractionalOffset.topRight,
              padding: EdgeInsets.only(top: 5),
              child: TextWidget(
                txt: attentionInsertHP,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: titleEmail,
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)))),
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: titleReEmail,
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)))),
                controller: _reEmailController,
              ),
            )
          ],
        ),
      ),
    );
  }

onChangeData() {
  widget.onChangeData(
      _phoneController.text, _emailController.text, _reEmailController.text);
}

_initialValue() {
  SharedPreferencesHelper.getDoRegistration().then((onValue) {
    doRegistrationModel = DoRegistrationModel.fromJson(json.decode(onValue));
    setState(() {
      _name = doRegistrationModel.data.name;
    });
  });

  SharedPreferencesHelper.getPhone().then((value) {
    _phoneController.text = value;
  });

  SharedPreferencesHelper.getEmail().then((value) {
    _emailController.text = value;
    _reEmailController.text = value;
  });
}}
