import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class StepOne extends StatefulWidget {
  Function onSubmit;

  @override
  State<StatefulWidget> createState() {
    return StepOneState();
  }

  StepOne(this.onSubmit);
}

class StepOneState extends State<StepOne> {
  String dayValue;
  String yearValue;
  String monthValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "lib/assets/images/dummycard.png",
            height: 100,
            width: MediaQuery.of(context).size.width / 3,
          ),
          TextWidget(txt: attentionInsertCard, color: Colors.blue, txtSize: 10),
          _insertCard(),
          _insertDate(),
          _btnSubmit()
        ],
      ),
    );
  }

  Widget _insertCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLength: 16,
        decoration: InputDecoration(
            labelText: titleInsertCard,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)))),
      ),
    );
  }

  Widget _insertDate() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextWidget(txt: titleDOB, txtSize: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _dayInput(),
              _monthInput(),
              _yearsInput(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dayInput() {
    return Container(
      alignment: FractionalOffset.center,
      width: MediaQuery.of(context).size.width / 5,
      decoration: BoxDecoration(
          border: Border.all(
              width: 2, style: BorderStyle.solid, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Date'),
          value: dayValue,
          onChanged: (newValue) {
            setState(() {
              dayValue = newValue;
            });
          },
          items: <String>["01", "02", "03", "04", "05"]
              .map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }

  Widget _monthInput() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 5.0, left: 5.0),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2, style: BorderStyle.solid, color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text('Month'),
            value: monthValue,
            onChanged: (newValue) {
              setState(() {
                monthValue = newValue;
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
      ),
    );
  }

  Widget _yearsInput() {
    return Container(
      alignment: FractionalOffset.center,
      width: MediaQuery.of(context).size.width / 5,
      decoration: BoxDecoration(
          border: Border.all(
              width: 2, style: BorderStyle.solid, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Year'),
          value: yearValue,
          onChanged: (newValue) {
            setState(() {
              yearValue = newValue;
            });
          },
          items: <String>["2017", "2018", "2019", "2020", "2021"]
              .map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }

  Widget _btnSubmit() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
      child: ButtonWidget(
          height: 40,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'SUBMIT',
          btnColor: Colors.blue,
          borderRedius: 5,
          onClick: () => {
            widget.onSubmit()
          }),
    );
  }
}
