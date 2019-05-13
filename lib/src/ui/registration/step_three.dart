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
          _rowNoCard('8000123456789101'),
          _rowTglLahir('20 September 2019'),
          _rowName('Andi Arlyn Anwar'),
          _rowNoHp('0812345678'),
          _rowEmail('enoraden@gmail.com'),
          _confirmation()
        ],
      ),
    );
  }

  Widget _rowNoCard(String vCardNo) {
    return Row(
      children: <Widget>[
        TextWidget(txt: titleNoCard),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
          child: TextWidget(
            txt: vCardNo,
            color: Colors.blue,
          ),
        )
      ],
    );
  }

  Widget _rowTglLahir(String vTglLahir) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: <Widget>[
          TextWidget(txt: titleDOB),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 6.5),
            child: TextWidget(
              txt: vTglLahir,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  Widget _rowName(String vName) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: <Widget>[
          TextWidget(txt: titleName),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 3.6),
            child: TextWidget(
              txt: vName,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  Widget _rowNoHp(String vNoHp) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: <Widget>[
          TextWidget(txt: titleNoHp),
          Padding(
            padding:
            EdgeInsets.only(left: 30),
            child: TextWidget(
              txt: vNoHp,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  Widget _rowEmail(String vEmail) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: <Widget>[
          TextWidget(txt: titleEmail),
          Padding(
            padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
            child: TextWidget(
              txt: vEmail,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  Widget _confirmation(){
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TextWidget(txt: contConfirmUserInfo, txtSize: 12,),
    );
  }
}
