import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/bloc-provider.dart';
import 'package:jasindo_app/src/ui/main_menu/main_menu.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class MyQr extends StatefulWidget {
  final String cardNo;

  MyQr(this.cardNo);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyQr> {
  Future<String> _barcodeString;
  String result;
  Dio _dio;

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
    _dio = Dio();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          title: const Text('AdPass QR'),
        ),
        body: new Center(
            child: new FutureBuilder<String>(
                future: _barcodeString,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Column(
                    children: <Widget>[
                      new Text(snapshot.data != null ? snapshot.data : ''),
                      SizedBox(
                        height: 30,
                      ),
                      new Text(result != null ? result : 'Loading....'),
                    ],
                  );
                })),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            scanQR();
          },
          tooltip: 'Reader the QRCode',
          child: new Icon(Icons.add_a_photo),
        ),
      ),
    );
  }

  Future<void> scanQR() async {
    _barcodeString = new QRCodeReader()
        .setAutoFocusIntervalInMs(200)
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
    setState(() {});
  }

  Future<void> postData(String data) async {
    var response = await _dio.get(
        "https://mobile.admedika.co.id/admedgateway/services/adpas/api.php?method=AdPasTnxRequest&p1=8000991200010208&p2=${data.toString()}",
        data: null);

    setState(() {
      result = response.toString();
    });
  }
}
