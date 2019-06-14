import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/blocs/activeuser_bloc.dart';
import 'package:jasindo_app/src/models/requests/do_req_activeuser.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/ProgressDialog.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';
import 'package:jasindo_app/widgets/pin_input/pin_put.dart';

class StepFive extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StepFiveState();
  }
}

class StepFiveState extends State<StepFive> {
  bool _isLoading = false;
  String _code = "";
  String _email = "";
  ActiveUserBloc bloc = ActiveUserBloc();

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.getEmail().then((value) {
      setState(() {
        _email = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    SharedPreferencesHelper.clearAllPreference();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 40.0, top: 30.0, right: 40),
          child: Column(
            children: <Widget>[
              Icon(Icons.mail),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextWidget(
                  txt: attentionVerifyMail,
                  txtSize: 12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextWidget(
                  txt: _email,
                  color: Colors.red,
                  txtSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextWidget(
                  txt: attentionActiveAccount,
                  txtSize: 12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextWidget(
                  txt: attentionCheckMail,
                  txtSize: 8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PinPut(
                  fieldsCount: 4,
                  actionButtonsEnabled: false,
                  onSubmit: (code) => {this._code = code},
                ),
              ),
              _btnAktifasi(),
              TextWidget(
                txt: attentionCodeNotSend,
                txtSize: 8,
              ),
              _btnResendCode()
            ],
          ),
        ),
      ),
      inAsyncCall: _isLoading,
    );
  }

  Widget _btnAktifasi() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 25.0),
      child: ButtonWidget(
          height: 40,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'AKTIFASI',
          btnColor: Colors.blue,
          borderRedius: 5,
          onClick: () => {_onSubmit()}),
    );
  }

  Widget _btnResendCode() {
    return Container(
      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 6, 2.0,
          MediaQuery.of(context).size.width / 6, 0.0),
      child: ButtonWidget(
          height: 30,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'KIRIM ULANG',
          btnColor: Colors.red,
          borderRedius: 5,
          onClick: () => {debugPrint('btn success')}),
    );
  }

  _onSubmit() {
    setState(() {
      _isLoading = true;
    });
    ReqActiveUser request = ReqActiveUser(email: _email, code: _code);
    bloc.activeUser(
        request.toMap(),
        (status, data) => {
              _getData(status, data),
            });
  }

  _getData(bool status, String message) {
    setState(() {
      _isLoading = false;
    });
    if (status) {
      Navigator.pushNamedAndRemoveUntil(context, "/login_menu", (_) => false);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
