import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/blocs/forgotpass_bloc.dart';
import 'package:jasindo_app/src/models/requests/do_req_forgot.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/ProgressDialog.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  ForgotPassBloc bloc = ForgotPassBloc();
  final emailController = TextEditingController();
  bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white),
      body: Builder(
        builder: (BuildContext context) => ProgressDialog(
              child: Container(
                margin: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      txt: titleForgotPass,
                      color: blueStandart,
                      txtSize: 28,
                      align: TextAlign.left,
                      fontFamily: 'SF-Bold',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                        txt: descFortgotPass,
                        txtSize: 12,
                        align: TextAlign.left),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 0.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: "Email"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 40, left: 40, top: 50),
                      child: ButtonWidget(
                          height: 50,
                          txtSize: 14,
                          txtColor: Colors.white,
                          txt: 'KIRIM',
                          btnColor: blueStandart,
                          borderRedius: 5,
                          onClick: () => {_onSubmit()}),
                    ),
                  ],
                ),
              ),
              inAsyncCall: _isLoading,
            ),
      ),
    );
  }

  _onSubmit() {
    setState(() {
      _isLoading = true;
    });
    ReqDoForgot forgot = ReqDoForgot(email: emailController.text);
    bloc.actForgotPass(
        forgot.toMap(),
        (status, data) => {
              _getData(status, data),
            });
  }

  _getData(bool status, String message) {
    setState(() {
      _isLoading = false;
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
