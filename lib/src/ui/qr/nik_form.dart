import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jasindo_app/src/ui/qr/pin_qr.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';

class NikForm extends StatefulWidget {
  final String nik;

  @override
  State<StatefulWidget> createState() {
    return NikFormState();
  }

  NikForm(this.nik);
}

class NikFormState extends State<NikForm> {
  File _image;
  bool mergeDataNik = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Foto KTP'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Platform.isAndroid
                  ? FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return previewImage();
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text(
                                'You have not yet picked an image.',
                                textAlign: TextAlign.center,
                              );
                            }
                        }
                      },
                    )
                  : previewImage(),
              _btnSubmit(),
              _image != null ? _btnRegister() : Container()
            ],
          ),
        ));
  }

  Future getTextImage() async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(_image);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          print(element.text);
          if (element.text.contains(widget.nik.substring(0,9))) {
            setState(() {
              mergeDataNik = true;
            });
            break;
          }
        }
      }
    }

    textRecognizer.close();
    !mergeDataNik
        ? _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('KTP Not Valid')))
        : routeToWidget(context, PinQR());
  }

  Future<void> getImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Widget previewImage() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: _image == null
          ? Text('No image selected.')
          : Image.file(
              _image,
              height: MediaQuery.of(context).size.width,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _btnSubmit() {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60, top: 30),
      child: ButtonWidget(
          height: 40,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'Capture',
          btnColor: blueStandart,
          borderRedius: 5,
          onClick: () => {
                getImage(),
              }),
    );
  }

  Widget _btnRegister() {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60, top: 10),
      child: ButtonWidget(
          height: 40,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'Register',
          btnColor: blueStandart,
          borderRedius: 5,
          onClick: () => {
                getTextImage(),
              }),
    );
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = response.file;
      });
    } else {
      print(response.exception.code);
    }
  }
}
