import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/about_bloc.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart' as u;
import 'package:jasindo_app/widgets/ImageSvg.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

import 'package:jasindo_app/src/ui/main_menu/menu_side/settings/change_pass.dart';
import '../../../term_condition.dart';
import 'contact_jasindo.dart';

class Setting extends StatefulWidget {
  AboutBloc blocAbout;

  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }

  Setting(this.blocAbout);
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
              child: ImageSvg(
                  isNetwork: false, pathImage: 'lib/assets/images/logo.svg'),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 50, right: 50),
              child: TextWidget(
                txt:
                    'Jasindo Health merupakan aplikasi ponsel dari PT. Asuransi Jasa Indonesia (PERSERO)',
                color: blueStandart,
              ),
            ),
            SizedBox(height: 20),
            _rowSyarat(),
            SizedBox(height: 30),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              color: blueStandart,
              onPressed: () => {u.routeToWidget(context, JasindoContact())},
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
                  color: orangeColor1,
                ),
                label: TextWidget(
                  txt: 'Keluar Aplikasi',
                  color: orangeColor1,
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3))),
            color: blueStandart,
            onPressed: () => {u.routeToWidget(context, TermCondition(widget.blocAbout))},
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3))),
            color: blueStandart,
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
