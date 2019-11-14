import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jasindo_app/src/blocs/bloc-provider.dart';
import 'package:jasindo_app/src/ui/main_menu/main_menu.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/ProgressDialog.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class MyQr extends StatefulWidget {
  final String cardNo;

  MyQr(this.cardNo);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyQr> {
  Future<String> _barcodeString;
  String result = "<br>";
  bool isScan = false;

  //bool isLoading = false;
  Dio _dio;
  Widget widgetView;
  static String tokenFirebase = "";

  Future<bool> _onWillPop() {
    return Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) {
      return BlocProvider(
        child: MainMenu(),
      );
    }), (_) => false);
  }

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.getTokenFirebase().then((value) {
      tokenFirebase = value;
    });
    _dio = Dio();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          title: const TextWidget(
            txt: 'QRADS',
            color: Colors.black,
          ),
        ),
        body: ProgressDialog(
          child: new Container(
              padding: EdgeInsets.all(10),
              alignment: FractionalOffset.center,
              child: !isScan
                  ? Container()
                  : new FutureBuilder<String>(
                      future: _barcodeString,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return widgetView;
                      })),
          inAsyncCall: !isScan,
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            scanQR();
          },
          tooltip: 'QRAD',
          backgroundColor: Colors.red,
          child: new Icon(Icons.center_focus_weak),
        ),
      ),
    );
  }

  Future<void> scanQR() async {
    _barcodeString = new QRCodeReader()
        .setForceAutoFocus(true)
        .setTorchEnabled(true)
        .setHandlePermissions(true)
        .setExecuteAfterPermissionGranted(true)
        .scan();

    _barcodeString.then((value) {
      getQR(value);
    });
  }

  getQR(String data) {
    _barcodeString.then((value) => {
          postData(value),
        });
  }

  Future<void> postData(String data) async {
    setState(() {
      isScan = false;
    });
    var response = await _dio.get(
        "https://mobile.admedika.com/admedgateway/services/adpas/api.php?method=AdPasTnxRequest&p1=${widget.cardNo}&p2=${data.toString()}&p3=$tokenFirebase");
    final jsonData = json.decode(response.toString());
    setState(() {
      isScan = true;
      widgetView = jsonData['admedika'][0]['status'] == "Success"
          ? eligible(jsonData['admedika'][0]['printOUT'])
          : notEligible(jsonData['admedika'][0]['status']);
    });
  }

  Widget eligible(String result) {
    return Column(
      children: <Widget>[
        Image.asset(
          'lib/assets/images/admedika.png',
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
              child: TextWidget(
            txt: "Sukses Pendaftaran",
            txtSize: 21,
            color: Colors.red,
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: TextWidget(
            align: TextAlign.justify,
            txt:
                "Terima kasih sudah menggunakan fitur QR Admedika. Pendaftaran kamu sudah dilakukan dan sudah di terima Rumah Sakit / Klinik. Mohon dapat menunggu proses selanjutnya.",
          ),
        ),
        Card(
          margin: EdgeInsets.only(top: 8.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                color: Colors.blueGrey,
                child: TextWidget(
                  color: Colors.white,
                  align: TextAlign.center,
                  txt: "Detail Information",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Html(data: result),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget notEligible(String result) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'lib/assets/images/not_eligible.png',
          height: 60,
        ),
        TextWidget(
          txt: result,
        )
      ],
    );
  }
}
