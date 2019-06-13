import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/blocs/register_bloc.dart';
import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/src/models/requests/do_req_registerinternal.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart' as u;
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class StepFour extends StatefulWidget {
  Function onClickRegister;

  @override
  State<StatefulWidget> createState() {
    return StepFourState();
  }

  StepFour({Key key, this.onClickRegister}) : super(key: key);
}

class StepFourState extends State<StepFour> {
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  DoRegisterBloc bloc = DoRegisterBloc();
  bool checkPolicy = false;
  String code = "";
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
    generateCode().then((value) {
      _setCode(value);
    });
    _populateData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 40.0, top: 30.0, right: 40),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: titlePassword,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                controller: _rePasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: titleRepassword,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
            ),
            Container(
              alignment: FractionalOffset.topLeft,
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: TextWidget(
                txt: attentionCode,
                color: Colors.black,
              ),
            ),
            Row(
              children: <Widget>[
                TextWidget(
                  txt: code,
                  txtSize: 20,
                  color: Colors.blue,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)))),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: checkPolicy,
                    onChanged: (value) {
                      setState(() {
                        checkPolicy = value;
                      });
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Container(
                        alignment: FractionalOffset.topLeft,
                        child: TextWidget(
                          txtSize: 12,
                          txt:
                              'Saya menyetujui Syarat & Ketentuan yang berlaku',
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            _btnDaftar()
          ],
        ),
      ),
    );
  }

  Widget _btnDaftar() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
      child: ButtonWidget(
          height: 40,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'DAFTAR',
          btnColor: Colors.blue,
          borderRedius: 5,
          onClick: () => {_onSubmit()}),
    );
  }

  _onSubmit() {
    if (_passwordController.text != _rePasswordController.text) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Password tidak sama")));
    } else {
      ReqRegistrationInternal request = ReqRegistrationInternal(
          name: _name,
          password: _passwordController.text,
          email: _email,
          birthDate: _birthDate,
          cardNumber: _cardNumber,
          activeCode: code,
          phone: _phone);
      print(json.encode(request.toMap()));
      bloc.fetchDoRegisterInternal(request.toMap(), (status, message) {
        if (status) {
          widget.onClickRegister();
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
        }
      });
    }
  }

  _populateData() {
    SharedPreferencesHelper.getDoRegistration().then((onValue) {
      DoRegistrationModel doRegistrationModel =
          DoRegistrationModel.fromJson(json.decode(onValue));
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
      _birthDate = _year + '-' + _month + '-' + _day;
    });

    SharedPreferencesHelper.getPhone().then((value) {
      _phone = value;
    });

    SharedPreferencesHelper.getEmail().then((value) {
      _email = value;
    });
  }

  Future<String> generateCode() async {
    code = await u.randomString();
    return code;
  }

  _setCode(String code) {
    setState(() {
      this.code = code;
    });
  }
}
