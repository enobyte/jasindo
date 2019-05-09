import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final String txt;
  final Color color;
  final double txtSize;
  final String fontFamily;

  const TextWidget({this.txt, this.color, this.txtSize, this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(txt,
        style:
            TextStyle(color: color, fontSize: txtSize, fontFamily: fontFamily),
        textAlign: TextAlign.center);
  }
}
