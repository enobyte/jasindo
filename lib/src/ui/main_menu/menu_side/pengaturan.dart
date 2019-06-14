import 'package:flutter/material.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart' as u;
import 'package:jasindo_app/widgets/TextWidget.dart';

import '../../change_pass.dart';
import '../../term_condition.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: FractionalOffset.center,
              child: Image.asset(
                'lib/assets/images/login_img.png',
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 50, right: 50),
              child: TextWidget(
                txt:
                    'Jasindo Health merupakan aplikasi ponsel dari PT. Asuransi Jasa Indonesia (PERSERO)',
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 15),
            _rowSyarat(),
            SizedBox(height: 15),
            RaisedButton(
              color: Colors.blue,
              onPressed: () => {},
              child: TextWidget(
                txt: 'Kontak Jasindo',
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
                color: Colors.transparent,
                elevation: 0,
                highlightElevation: 0.0,
                onPressed: () => {_logout()},
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.green,
                ),
                label: TextWidget(
                  txt: 'Keluar Aplikasi',
                  color: Colors.green,
                ))
          ],
        ),
      ),
    );
  }

  Widget _rowSyarat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonTheme(
          minWidth: MediaQuery.of(context).size.width / 3,
          child: RaisedButton(
            onPressed: () => {u.routeToWidget(context, TermCondition())},
            child: TextWidget(
              txt: 'Syarat & Ketentuan',
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ButtonTheme(
          minWidth: MediaQuery.of(context).size.width / 3,
          child: RaisedButton(
            onPressed: () => {
                  u.routeToWidget(
                    context,
                    new ChangePassword(),
                  )
                },
            child: TextWidget(
              txt: 'Ubah Kata Sandi',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  _logout() {
    SharedPreferencesHelper.clearAllPreference();
    Navigator.pushNamedAndRemoveUntil(context, "/prelogin_menu", (_) => false);
  }
}
