import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class StepTwo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StepTwoState();
  }
}

class StepTwoState extends State<StepTwo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40.0, top: 30.0, right: 40),
      child: Column(
        children: <Widget>[
          Container(
            alignment: FractionalOffset.topLeft,
            child: TextWidget(
              txt: 'Nama',
            ),
          ),
          Container(
            alignment: FractionalOffset.topLeft,
            child: TextWidget(
              txt: 'Andi Arlyn Anwar',
              txtSize: 24,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: titleNoHp,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
            ),
          ),
          Container(
            alignment: FractionalOffset.topRight,
            padding: EdgeInsets.only(top: 5),
            child: TextWidget(
              txt: attentionInsertHP,
              color: Colors.red,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: titleEmail,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: titleReEmail,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
            ),
          )
        ],
      ),
    );
  }
}
