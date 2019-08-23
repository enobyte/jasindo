import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jasindo_app/src/ui/qr/pin_qr.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';

class NikForm extends StatefulWidget {
  final String nik;
  final String name;
  final String cardNo;

  @override
  State<StatefulWidget> createState() {
    return NikFormState();
  }

  NikForm(this.nik, this.name, this.cardNo);
}

class NikFormState extends State<NikForm> {
  File _image;
  bool mergeDataNik = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Dio _dio;

  @override
  void initState() {
    super.initState();
    Options options = Options(
        receiveTimeout: 5000,
        connectTimeout: 5000,
        contentType: ContentType.parse("application/x-www-form-urlencoded"));
    _dio = Dio(options);
    _setupLoggingInterceptor();
  }

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
          if (element.text.contains(widget.nik.substring(0, 9))) {
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
        : compressImage(_image);
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

  Future<void> compressImage(File file) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      file.absolute.path,
      quality: 50,
      rotate: 0,
    );
    postData(result);
  }

  Future<void> postData(File image) async {
    var response = await _dio.post(
        "https://mobile.admedika.co.id/admedgateway/services/adpas/registerAdpasQR.php",
        onUploadProgress: (int sent, int total) {
      print("$sent $total");
    },
        data: FormData.from({
          "uploadedFile": UploadFileInfo(
            new File(_image.path),
            "KTP",
          ),
          "cardNo": widget.cardNo,
          "mediaName": "NIK",
          "mediaNo": widget.nik,
          "userCode": widget.name,
          //new UploadFileInfo(new File(_image.path), "uploadedFile.jpg"),
        }));

    Map<String, dynamic> map = jsonDecode(response.toString());
    if (map['admedika']['status'].toString().contains("Successfully")) {
      routeToWidget(context, PinQR(cardNo: widget.cardNo));
    } else {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(map['admedika']['status'].toString())));
    }
  }

  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;

    _dio.interceptor.request.onSend = (Options options) {
      print("--> ${options.method} ${options.path}");
      print("Header: ${options.headers}");
      print("Content type: ${options.contentType}");
      print("Body: ${options.data}");
      print("<-- END HTTP");
      return options;
    };

    _dio.interceptor.response.onSuccess = (Response response) {
      print(
          "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
      String responseAsString = response.data.toString();
      if (responseAsString.length > maxCharactersPerLine) {
        int iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
        for (int i = 0; i <= iterations; i++) {
          int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(
              i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(response.data);
      }
      print("<-- END HTTP");
    };
  }
}
