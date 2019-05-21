import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class ButtonWidget extends StatelessWidget {
  final String txt;
  final double txtSize;
  final Color txtColor;
  final double height;
  final Color btnColor;
  final Function onClick;
  double borderRedius = 0.0;

  ButtonWidget(
      {this.txt,
      this.txtColor,
      this.height,
      this.btnColor,
      this.txtSize,
      this.onClick,
      double borderRedius}) {
    this.borderRedius = borderRedius;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ButtonTheme(
        child: new RaisedButton(
          child: TextWidget(
            color: txtColor,
            txt: txt,
            txtSize: txtSize,
          ),
          elevation: 0.0,
          color: btnColor,
          splashColor: Colors.blueAccent,
          onPressed: () {
            this.onClick();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRedius)),
        ),
        height: height,
      ),
    );
  }
}
