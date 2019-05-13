import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class StepFour extends StatefulWidget {
  final String code;

  @override
  State<StatefulWidget> createState() {
    return StepFourState();
  }

  StepFour({Key key, this.code}) : super(key: key);
}

class StepFourState extends State<StepFour> {
  bool checkPolicy = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40.0, top: 30.0, right: 40),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: titlePassword,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: titleRepassword,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
            ),
          ),
          Container(
            alignment: FractionalOffset.topLeft,
            padding: EdgeInsets.only(top: 30, bottom: 10),
            child: TextWidget(
              txt: attentionCode,
              color: Colors.black,
            ),
          ),
          Row(
            children: <Widget>[
              TextWidget(
                txt: widget.code,
                txtSize: 20,
                color: Colors.blue,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        //labelText: titleRepassword,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)))),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: checkPolicy,
                  onChanged: (value) {
                    setState(() {
                      checkPolicy = value;
                    });
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                      alignment: FractionalOffset.topLeft,
                      child: TextWidget(
                        txtSize: 12,
                        txt: 'Saya menyetujui Syarat & Ketentuan yang berlaku',
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _btnDaftar()
        ],
      ),
    );
  }

  Widget _btnDaftar() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
      child: ButtonWidget(
          height: 40,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'DAFTAR',
          btnColor: Colors.blue,
          borderRedius: 5,
          onClick: () => {debugPrint('btn success')}),
    );
  }
}
