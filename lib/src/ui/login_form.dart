import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/bloc-provider.dart';
import 'package:jasindo_app/src/blocs/login_bloc.dart';
import 'package:jasindo_app/src/models/requests/do_req_login.dart';
import 'package:jasindo_app/src/ui/forgot_password.dart';
import 'package:jasindo_app/src/ui/registration/register_form.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/widgets/ProgressDialog.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  bool _isHidePassword = true;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final DoLoginBloc bloc = DoLoginBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ProgressDialog(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(
                  txt: "Selamat Datang!",
                  color: blueStandart,
                  txtSize: 30,
                  fontFamily: 'SF-Bold'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                child: TextFormField(
                  controller: _passController,
                  obscureText: _isHidePassword,
                  decoration: InputDecoration(
                      labelText: "Kata Sandi",
                      suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
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
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                alignment: FractionalOffset.centerRight,
                child: InkWell(
                  child: TextWidget(
                      txt: "Lupa Kata Sandi",
                      color: blueStandart,
                      fontFamily: 'SF-Semibold'),
                  onTap: () => {_openForgotPassword(context)},
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 70.0, 40.0, 0.0),
                  child: ButtonTheme(
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: TextWidget(
                        color: Colors.white,
                        txt: 'LOGIN',
                        txtSize: 14.0,
                      ),
                      elevation: 4.0,
                      color: blueStandart,
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        _onSubmitLogin(context);
                      },
                    ),
                    height: 50.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(flex: 20),
                    TextWidget(txt: "Pengguna Baru?"),
                    Spacer(flex: 1),
                    GestureDetector(
                      child: TextWidget(
                        txt: "DAFTAR",
                        color: blueStandart,
                        fontFamily: 'SF-Semibold',
                      ),
                      onTap: () => {_openRegisterForm(context)},
                    ),
                    Spacer(flex: 20),
                  ],
                ),
              )
            ],
          ),
        ),
        inAsyncCall: _isLoading,
      ),
    );
  }

  _openRegisterForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          child: RegisterForm(),
        );
      }),
    );
  }

  _onSubmitLogin(BuildContext context) {
    setState(() {
      _isLoading = true;
    });
    ReqDoLogin request = ReqDoLogin(
        email: _emailController.text, password: _passController.text);
    bloc.fetchDoLogin(
        request.toMap(),
        (status, message) => {
              _openMainMenu(status, message),
            });
  }

  _openMainMenu(status, message) {
    setState(() {
      _isLoading = false;
    });
    if (status) {
      Navigator.pushNamedAndRemoveUntil(context, "/main_menu", (_) => false);
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  _openForgotPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          child: ForgotPassword(),
        );
      }),
    );
  }
}
