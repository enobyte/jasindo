import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/models/adcps/members_model.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class StepTwo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StepTwoState();
  }
}

class StepTwoState extends State<StepTwo> {
  MemberModels memberModel;
  String _name = "";

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.getMember().then((onValue) {
      memberModel = MemberModels.fromJson(json.decode(onValue));
      setState(() {
        _name = memberModel.data.name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
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
                    txt: _name,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)))),
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: titleEmail,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: titleReEmail,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)))),
                  ),
                )
              ],
            ),
          );
        });
  }
}
