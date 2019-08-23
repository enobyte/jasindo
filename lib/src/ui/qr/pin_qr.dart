import 'package:flutter/material.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:pin_view/pin_view.dart';

import 'barcode_qr.dart';

class PinQR extends StatefulWidget {
  final String cardNo;

  @override
  State<StatefulWidget> createState() {
    return PinQRState();
  }

  PinQR({Key key, this.cardNo}) : super(key: key);
}

class PinQRState extends State<PinQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.sms,
                          size: 100.0, color: Theme.of(context).primaryColor),
                      Container(margin: EdgeInsets.symmetric(vertical: 5.0)),
                      Container(margin: EdgeInsets.symmetric(vertical: 5.0)),
                      PinView(
                          count: 6,
                          // describes the field number
                          dashPositions: [2, 4],
                          // positions of dashes, you can add multiple
                          autoFocusFirstField: false,
                          // defaults to true
                          margin: EdgeInsets.all(2.5),
                          // margin between the fields
                          obscureText: false,
                          // describes whether the text fields should be obscure or not, defaults to false
                          style: TextStyle(
                              // style for the fields
                              fontSize: 19.0,
                              fontWeight: FontWeight.w500),
                          dashStyle: TextStyle(
                              // dash style
                              fontSize: 25.0,
                              color: Colors.grey),
                          submit: (String pin) {
                            routeToWidget(context, MyQr(widget.cardNo));
                          })
                    ]))));
  }
}
