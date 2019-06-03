import 'package:flutter/material.dart';
import 'package:jasindo_app/widgets/ImageCover.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class ProviderRekanan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProviderRekananState();
  }
}

class ProviderRekananState extends State<ProviderRekanan> {
  String cityValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: TextWidget(txt: "Provider Rekanan", color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[_bannerTop(), _viewBottom()],
      ),
    );
  }

  Widget _bannerTop() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: ImageCover(false, ''),
    );
  }

  Widget _viewBottom() {
    return Column(
      children: <Widget>[
        _searchAllCity(),
        _searchChooseJaminan(),
        _btnSubmit(),
        _btnNearme()
      ],
    );
  }

  Widget _searchAllCity() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      height: 40,
      alignment: FractionalOffset.center,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('SEMUA JAMINAN'),
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              //monthValue = newValue;
            });
          },
          items: <String>[
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            'Dec'
          ].map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }

  Widget _searchChooseJaminan() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      height: 40,
      alignment: FractionalOffset.center,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('PILIH JAMINAN'),
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              //monthValue = newValue;
            });
          },
          items: <String>[
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            'Dec'
          ].map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }

  Widget _btnSubmit() {
    return RaisedButton(
      onPressed: () => {},
      textColor: Colors.white,
      color: Color.fromRGBO(0, 96, 153, 1.0),
      splashColor: Colors.blueGrey,
      padding: EdgeInsets.only(left: 50, right: 50),
      child: new TextWidget(
        txt: "SUBMIT",
      ),
    );
  }

  Widget _btnNearme() {
    return RaisedButton(
      onPressed: () => {},
      textColor: Colors.white,
      color: Colors.orange,
      splashColor: Colors.blueGrey,
      padding: EdgeInsets.only(left: 46, right: 46),
      child: new TextWidget(
        txt: "NEAR ME",
      ),
    );
  }
}
