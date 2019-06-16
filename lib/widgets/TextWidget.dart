import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final String txt;
  final Color color;
  final double txtSize;
  final String fontFamily;
  final TextAlign align;
  final int maxLine;

  const TextWidget(
      {Key key,
      this.txt,
      this.color,
      this.txtSize,
      this.fontFamily,
      this.align,
      this.maxLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(txt == null ? "" : txt,
        maxLines: maxLine,
        style:
            TextStyle(color: color, fontSize: txtSize, fontFamily: fontFamily),
        textAlign: align != null ? this.align : TextAlign.center);
  }
}
