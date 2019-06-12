import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/blocs/forgotpass_bloc.dart';
import 'package:jasindo_app/src/models/requests/doReqForgot.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/ProgressDialog.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';
import 'package:jasindo_app/utility/utils.dart' as u;

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
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white),
      body: Builder(
        builder: (BuildContext context) => ProgressDialog(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      txt: titleForgotPass,
                      color: Colors.blue,
                      txtSize: 24,
                      align: TextAlign.left,
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
                    ButtonWidget(
                        height: 40,
                        txtSize: 12,
                        txtColor: Colors.white,
                        txt: 'KIRIM',
                        btnColor: Colors.blue,
                        borderRedius: 5,
                        onClick: () => {_onSubmit()}),
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
