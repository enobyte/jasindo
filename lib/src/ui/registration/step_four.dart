import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/blocs/about_bloc.dart';
import 'package:jasindo_app/src/blocs/register_bloc.dart';
import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/src/models/requests/do_req_registerinternal.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart' as u;
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

import '../term_condition.dart';

class StepFour extends StatefulWidget {
  Function onClickRegister;
  AboutBloc blocAbout;

  @override
  State<StatefulWidget> createState() {
    return StepFourState();
  }

  StepFour({Key key, this.onClickRegister, this.blocAbout}) : super(key: key);
}

class StepFourState extends State<StepFour> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _verificationCodeController = TextEditingController();
  DoRegisterBloc bloc = DoRegisterBloc();
  bool _checkPolicy = false;
  bool _verifyCode = false;
  bool _isNewHidePass = true;
  bool _isReNewPass = true;
  String code = "";
  String _email;
  String _day;
  String _month;
  String _year;
  String _name;
  String _phone;
  String _cardNumber;
  String _birthDate;
  String tokenFirebase = "";

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      tokenFirebase = token;
    });
    generateCode().then((value) {
      _setCode(value);
    });
    _populateData();
    _verificationCodeController.addListener(onChangeVerifyCode);
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _verificationCodeController.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 40.0, top: 0.0, right: 40),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                obscureText: _isNewHidePass,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: titlePassword,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  suffixIcon: IconButton(
                      icon: _isNewHidePass
                          ? Icon(Icons.vpn_key)
                          : Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          if (_isNewHidePass) {
                            _isNewHidePass = false;
                          } else {
                            _isNewHidePass = true;
                          }
                        });
                      }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                controller: _rePasswordController,
                obscureText: _isReNewPass,
                decoration: InputDecoration(
                  labelText: titleRepassword,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  suffixIcon: IconButton(
                      icon: _isReNewPass
                          ? Icon(Icons.vpn_key)
                          : Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          if (_isReNewPass) {
                            _isReNewPass = false;
                          } else {
                            _isReNewPass = true;
                          }
                        });
                      }),
                ),
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
                      controller: _verificationCodeController,
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
                    value: _checkPolicy,
                    onChanged: (value) {
                      setState(() {
                        _checkPolicy = value;
                      });
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Container(
                        alignment: FractionalOffset.topLeft,
                        child: RichText(
                          text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                    text: 'Saya menyetujui ',
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        u.routeToWidget(context,
                                            TermCondition(widget.blocAbout));
                                      },
                                    text: 'Syarat & Ketentuan ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: orangeColor1,
                                    )),
                                TextSpan(
                                    text: 'yang berlaku',
                                    style: TextStyle(fontSize: 12)),
                              ]),
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
      margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
      child: ButtonWidget(
          height: 40,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'DAFTAR',
          btnColor: blueStandart,
          borderRedius: 5,
          onClick: () => {_getCode()}),
    );
  }

  _onSubmit(String code) {
    if (_passwordController.text != _rePasswordController.text) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Password tidak sama")));
    } else if (!_verifyCode) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Kode verifikasi salah")));
    } else if (!_checkPolicy) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Checklist syarat dan ketentuan")));
    } else {
      ReqRegistrationInternal request = ReqRegistrationInternal(
          name: _name,
          password: _passwordController.text,
          email: _email,
          birthDate: _birthDate,
          cardNumber: _cardNumber,
          activeCode: code,
          phone: _phone,
          firebaseToken: tokenFirebase);
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

  _getCode() {
    if (_checkPolicy && _verifyCode) {
      generateCode().then((onValue) {
        _onSubmit(onValue);
      });
    } else {
      _onSubmit("");
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

  onChangeVerifyCode() {
    if (_verificationCodeController.text.toUpperCase() == this.code) {
      setState(() {
        _verifyCode = true;
      });
    } else {
      setState(() {
        _verifyCode = false;
      });
    }
  }
}
