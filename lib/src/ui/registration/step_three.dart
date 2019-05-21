import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class StepThree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StepThreeState();
  }
}

class StepThreeState extends State<StepThree> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40.0, top: 30.0, right: 40),
      child: Column(
        children: <Widget>[
          _viewInformation('8000123456789101', '20 September 2019',
              'Andi Arlyn Anwar', '0812345678', 'enoraden@gmail.com'),
          _confirmation()
        ],
      ),
    );
  }

  Widget _confirmation() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TextWidget(
        txt: contConfirmUserInfo,
        txtSize: 12,
      ),
    );
  }

  Widget _titleInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextWidget(txt: titleNoCard),
        TextWidget(txt: titleDOB),
        TextWidget(txt: titleName),
        TextWidget(txt: titleNoHp),
        TextWidget(txt: titleEmail),
      ],
    );
  }

  Widget _valueInformation(vCardNo, vTglLahir, vName, vNoHp, vEmail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextWidget(
          txt: vCardNo,
          color: Colors.blue,
        ),
        TextWidget(
          txt: vTglLahir,
          color: Colors.blue,
        ),
        TextWidget(
          txt: vName,
          color: Colors.blue,
        ),
        TextWidget(
          txt: vNoHp,
          color: Colors.blue,
        ),
        TextWidget(
          txt: vEmail,
          color: Colors.blue,
        )
      ],
    );
  }

  Widget _viewInformation(vCardNo, vTglLahir, vName, vNoHp, vEmail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _titleInformation(),
        _valueInformation(vCardNo, vTglLahir, vName, vNoHp, vEmail)
      ],
    );
  }
}
