import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/changepass_bloc.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/requests/do_req_changepass.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/ProgressDialog.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordState();
  }
}

class ChangePasswordState extends State<ChangePassword> {
  bool _isHidePassword = true;
  bool _isNewHidePass = true;
  bool _isReNewPass = true;
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _renewPassword = TextEditingController();
  final bloc = ChangePassBloc();
  final _scaffolKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolKey,
      appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TextWidget(
            txt: 'Ubah Kata Sandi',
            color: Colors.black,
          )),
      body: ProgressDialog(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _oldPassword,
                  obscureText: _isHidePassword,
                  decoration: InputDecoration(
                      labelText: "Masukkan Kata Sandi Lama",
                      suffixIcon: IconButton(
                          icon: _isHidePassword ? Icon(Icons.vpn_key) : Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              if (_isHidePassword) {
                                _isHidePassword = false;
                              } else {
                                _isHidePassword = true;
                              }
                            });
                          })),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _newPassword,
                  obscureText: _isNewHidePass,
                  decoration: InputDecoration(
                      labelText: "Masukkan Kata Sandi Baru",
                      suffixIcon: IconButton(
                          icon: _isNewHidePass ? Icon(Icons.vpn_key) : Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              if (_isNewHidePass) {
                                _isNewHidePass = false;
                              } else {
                                _isNewHidePass  = true;
                              }
                            });
                          })),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _renewPassword,
                  obscureText: _isReNewPass,
                  decoration: InputDecoration(
                      labelText: "Ulangi Kata Sandi Baru",
                      suffixIcon: IconButton(
                          icon: _isReNewPass ? Icon(Icons.vpn_key) : Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              if (_isReNewPass) {
                                _isReNewPass = false;
                              } else {
                                _isReNewPass = true;
                              }
                            });
                          })),
                ),
                SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    color: blueStandart,
                    onPressed: () => {_changePassword()},
                    child: Container(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: TextWidget(txt: 'SIMPAN', color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
        inAsyncCall: _isLoading,
      ),
    );
  }

  _changePassword() {
    setState(() {
      _isLoading = true;
    });
    SharedPreferencesHelper.getDoLogin().then((onValue) {
      final memberModels = MemberModels.fromJson(json.decode(onValue));
      ReqChangePass request = ReqChangePass(
          email: memberModels.data.email,
          oldPass: _oldPassword.text,
          newPass: _newPassword.text);
      bloc.actForgotPass(request.toMap(),
              (status, message) => {_verifyChangePassword(status, message)});
    });
  }

  _verifyChangePassword(bool status, String message) {
    _scaffolKey.currentState.showSnackBar(SnackBar(content: Text(message)));
    setState(() {
      _isLoading = false;
    });
  }
}
