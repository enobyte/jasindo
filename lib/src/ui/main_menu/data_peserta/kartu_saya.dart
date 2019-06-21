import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class CardMember extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardMemberState();
  }
}

class CardMemberState extends State<CardMember> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: new Stack(
          children: <Widget>[
            Container(
              child: Image.asset('lib/assets/images/vipcard.png'),
              alignment: Alignment(0.0, 0.0),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 5,
                  bottom: MediaQuery.of(context).size.width / 12),
              child: TextWidget(
                txtSize: 24,
                align: TextAlign.end,
                txt: 'Eno'.toUpperCase(),
              ),
            )
          ],
        ),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}

//Stack(
//children: <Widget>[
//Container(
//alignment: Alignment.center,
//child: Image.asset('lib/assets/images/vipcard.png'),
//),
//Container(
//color: Colors.blue,
//alignment: Alignment(0.0, 0.0),
//child: Column(
//children: <Widget>[
//TextWidget(
//txt: "Eno",
//align: TextAlign.center,
//),
//],
//),
//)
//],
//);
