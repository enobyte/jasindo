import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/bloc-provider.dart';
import 'package:jasindo_app/src/ui/main_menu/main_menu.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class MyQr extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyQr> {
  Future<String> _barcodeString;

  Future<bool> _onWillPop() {
    return Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) {
      return BlocProvider(
        child: MainMenu(),
      );
    }), (_) => false);
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
                  return new Text(snapshot.data != null ? snapshot.data : '');
                })),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            setState(() {
              _barcodeString = new QRCodeReader()
                  .setAutoFocusIntervalInMs(200)
                  .setForceAutoFocus(true)
                  .setTorchEnabled(true)
                  .setHandlePermissions(true)
                  .setExecuteAfterPermissionGranted(true)
                  .scan();
            });
          },
          tooltip: 'Reader the QRCode',
          child: new Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
