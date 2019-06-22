import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/blocs/activeuser_bloc.dart';
import 'package:jasindo_app/src/models/requests/do_req_activeuser.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
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
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 40.0, top: 30.0, right: 40),
          child: Column(
            children: <Widget>[
              Image.asset(
                'lib/assets/images/ic_mail.png',
                height: 60,
              ),
              SizedBox(
                height: 15,
              ),
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
                  color: orangeColor1,
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
              Row(
                children: <Widget>[
                  Expanded(child: _btnResendCode()),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: _btnCallCenter())
                ],
              )
            ],
          ),
        ),
      ),
      inAsyncCall: _isLoading,
    );
  }

  Widget _btnAktifasi() {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 25.0),
      child: ButtonWidget(
          height: 40,
          txtSize: 16,
          txtColor: Colors.white,
          txt: 'AKTIFASI',
          btnColor: blueStandart,
          borderRedius: 5,
          onClick: () => {_onSubmit()}),
    );
  }

  Widget _btnResendCode() {
    return Column(
      children: <Widget>[
        TextWidget(
          txt: attentionCodeNotSend,
          txtSize: 12,
        ),
        Container(
          child: ButtonWidget(
              height: 30,
              txtSize: 12,
              txtColor: Colors.white,
              txt: 'KIRIM ULANG',
              btnColor: orangeColor1,
              borderRedius: 5,
              onClick: () => {debugPrint('btn success')}),
        ),
      ],
    );
  }

  Widget _btnCallCenter() {
    return Column(children: <Widget>[
      Container(
          alignment: Alignment.center,
          child: TextWidget(
            txtSize: 12,
            txt: "Kesulitan Daftar?",
            align: TextAlign.center,
          )),
      Container(
        child: ButtonWidget(
            height: 30,
            txtSize: 12,
            txtColor: Colors.white,
            txt: 'Hubungi Call Center',
            btnColor: orangeColor1,
            borderRedius: 5,
            onClick: () => {MakeCall(context, '021-29647522')}),
      ),
    ]);
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
