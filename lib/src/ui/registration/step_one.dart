import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/doregistration_bloc.dart';
import 'package:jasindo_app/src/models/key_value_model.dart';
import 'package:jasindo_app/src/models/requests/do_req_register.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart' as utils;
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/ProgressDialog.dart';
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
  String dayValue = '999';
  String yearValue = '999';
  String monthValue = '999';
  final _cardNumbController = TextEditingController();
  bool _validateCard = false;
  bool _isLoading = false;
  DoRegistrationBloc bloc = DoRegistrationBloc();
  List<String> monthList = List();

  final List<KeyValueModel> listMonth = [
    KeyValueModel(key: "01", value: "Jan"),
    KeyValueModel(key: "02", value: "Feb"),
    KeyValueModel(key: "03", value: "Mar"),
    KeyValueModel(key: "04", value: "Apr"),
    KeyValueModel(key: "05", value: "May"),
    KeyValueModel(key: "06", value: "Jun"),
    KeyValueModel(key: "07", value: "Jul"),
    KeyValueModel(key: "08", value: "Aug"),
    KeyValueModel(key: "09", value: "Sep"),
    KeyValueModel(key: "10", value: "Oct"),
    KeyValueModel(key: "11", value: "Nov"),
    KeyValueModel(key: "12", value: "Dec")
  ];

  final List<String> listDays = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31"
  ];

  final List<String> listYear = [
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    '2014',
    '2013',
    '2012',
    '2011',
    '2010',
    '2009',
    '2008',
    '2007',
    '2006',
    '2005',
    '2004',
    '2003',
    '2002',
    '2001',
    '2000',
    '1999',
    '1998',
    '1997',
    '1996',
    '1995',
    '1994',
    '1993',
    '1992',
    '1991',
    '1990',
    '1989',
    '1988',
    '1987',
    '1986',
    '1985',
    '1984',
    '1983',
    '1982',
    '1981',
    '1980',
    '1979',
    '1978',
    '1977',
    '1976',
    '1975',
    '1974',
    '1973',
    '1972',
    '1971',
    '1970',
    '1969',
    '1968',
    '1967',
    '1966',
    '1965',
    '1964',
    '1963',
    '1962',
    '1961',
    '1960',
    '1959',
    '1958',
    '1957',
    '1956',
    '1955',
    '1954',
    '1953',
    '1952',
    '1951',
    '1950',
    '1949',
    '1948',
    '1947',
    '1946',
    '1945',
    '1944',
    '1943',
    '1942',
    '1941',
    '1940',
  ];

  @override
  void initState() {
    super.initState();
    monthList = listMonth.map((value) => value.key).toList();
    _initalValue();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    _cardNumbController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "lib/assets/images/card.png",
                height: 100,
                width: MediaQuery.of(context).size.width / 3,
              ),
              TextWidget(
                  txt: attentionInsertCard, color: blueStandart, txtSize: 10),
              _insertCard(),
              _insertDate(),
              _btnSubmit(),
            ],
          ),
        ),
      ),
      inAsyncCall: _isLoading,
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
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            errorText: _validateCard ? "Pastikan No. kartu terisi dengan benar" : null),
        controller: _cardNumbController,
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
          value: listDays.firstWhere((data) => data.startsWith(dayValue),
              orElse: () => null),
          onChanged: (newValue) {
            setState(() {
              dayValue = newValue;
            });
          },
          items: listDays.map<DropdownMenuItem<String>>((value) {
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
        padding: EdgeInsets.only(right: 8, left: 8),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2, style: BorderStyle.solid, color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text('Month'),
            value: listMonth.map((value) => value.key).toList().firstWhere(
                (data) => data.startsWith(monthValue),
                orElse: () => null),
            onChanged: (newValue) {
              setState(() {
                monthValue = newValue;
              });
            },
            items: listMonth.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem(
                  value: value.key, child: Text(value.value));
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
          value: listYear.firstWhere((data) => data.startsWith(yearValue),
              orElse: () => null),
          onChanged: (newValue) {
            setState(() {
              yearValue = newValue;
            });
          },
          items: listYear.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }

  Widget _btnSubmit() {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60, top: 30),
      child: ButtonWidget(
          height: 40,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'SUBMIT',
          btnColor: blueStandart,
          borderRedius: 5,
          onClick: () => {
                _onSubmit(),
              }),
    );
  }

  void _onSubmit() {
    setState(() {
      if (_cardNumbController.text.length != 16) {
        _validateCard = true;
        return;
      } else {
        _validateCard = false;
      }
      if (dayValue == '999' || monthValue == '999' || yearValue == '999') {
        utils.showToast(context, 'Harap lengkapi tanggal lahir');
        return;
      } else {
        _doRegistration();
      }
      _isLoading = true;
    });
  }

  _doRegistration() {
    ReqDoRegistration request = ReqDoRegistration(
        cardNumber: _cardNumbController.text,
        birthDate: yearValue + '-' + monthValue + '-' + dayValue,
        email: "");
    bloc.fetchDoRegistration(
        request.toMap(),
        (status, message) => {
              _getData(status, message),
            });
  }

  _getData(bool status, String message) {
    setState(() {
      _isLoading = false;
    });
    if (status) {
      SharedPreferencesHelper.setCardNumb(_cardNumbController.text);
      SharedPreferencesHelper.setYear(yearValue);
      SharedPreferencesHelper.setMonth(monthValue);
      SharedPreferencesHelper.setDay(dayValue);
      widget.onSubmit();
    } else {
      utils.showToast(context, message);
    }
  }

  _initalValue() {
    SharedPreferencesHelper.getCardNumb().then((card) {
      _cardNumbController.text = card;
    });

    SharedPreferencesHelper.getDay().then((days) {
      dayValue = days;
    });

    SharedPreferencesHelper.getMonth().then((month) {
      monthValue = month;
    });

    SharedPreferencesHelper.getYear().then((year) {
      yearValue = year;
    });
  }
}
