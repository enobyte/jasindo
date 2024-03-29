import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/about_bloc.dart';
import 'package:jasindo_app/src/ui/registration/step_five.dart';
import 'package:jasindo_app/src/ui/registration/step_four.dart';
import 'package:jasindo_app/src/ui/registration/step_one.dart';
import 'package:jasindo_app/src/ui/registration/step_three.dart';
import 'package:jasindo_app/src/ui/registration/step_two.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  int _indexStep = 0;
  Color _indexColors = Colors.blue;
  bool _visibleNext = true;
  bool _visibleBack = true;
  final _blocAbout = AboutBloc();

  @override
  void dispose() {
    super.dispose();
    SharedPreferencesHelper.clearAllPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("DAFTAR", style: TextStyle(color: blueStandart)),
          centerTitle: true,
          backgroundColor: Colors.white),
      body: new Container(
        child: Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 15.0),
              child: _indexPoint(_indexStep, _indexColors),
            ),
            new Expanded(
              child: _preloadWidget(_indexStep),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Visibility(
                visible: _visibleBack,
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  fillColor: orangeColor1,
                  elevation: 0,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      TextWidget(
                        txt: 'BACK',
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: () => {_decrease()},
                ),
              ),
              Visibility(
                visible: _visibleNext,
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  fillColor: blueStandart,
                  elevation: 0,
                  child: Row(
                    children: <Widget>[
                      TextWidget(txt: 'NEXT', color: Colors.white),
                      Icon(Icons.arrow_forward_ios, color: Colors.white)
                    ],
                  ),
                  onPressed: () => {_increaseTab()},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _preloadWidget(index) {
    Widget _widget;
    switch (index) {
      case 0:
        setState(() {
          _visibleNavigation(false, false);
        });
        _widget = StepOne(() => {_increaseTab()});
        break;
      case 1:
        _widget = StepTwo((phone, email, reEmail) => {
              _validatingStepTwo(phone, email, reEmail),
            });
        break;
      case 2:
        setState(() {
          _visibleNavigation(true, true);
        });
        _widget = StepThree();
        break;
      case 3:
        setState(() {
          _visibleNavigation(false, true);
        });
        _widget = StepFour(
          blocAbout: _blocAbout,
          onClickRegister: () => {_increaseTab()},
        );
        break;
      case 4:
        setState(() {
          _visibleNavigation(false, false);
        });
        _widget = StepFive(isActive: true,);
        break;
    }
    return _widget;
  }

  Widget _indexPoint(int index, Color colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Divider(
            height: 5,
            indent: double.infinity,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: RaisedButton(
              color: index == 0 ? colors : Colors.transparent,
              splashColor: Colors.blueAccent,
              shape: CircleBorder(),
              child: TextWidget(
                  txt: '1', color: index == 0 ? Colors.white : Colors.black),
              onPressed: () {}),
        ),
        Expanded(
          child: Divider(
            height: 5,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: RaisedButton(
              color: index == 1 ? colors : Colors.transparent,
              splashColor: Colors.blueAccent,
              shape: CircleBorder(),
              child: TextWidget(
                  txt: '2', color: index == 1 ? Colors.white : Colors.black),
              onPressed: () {}),
        ),
        Expanded(
          child: Divider(
            height: 5,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: RaisedButton(
              color: index == 2 ? colors : Colors.transparent,
              splashColor: Colors.blueAccent,
              shape: CircleBorder(),
              child: TextWidget(
                  txt: '3', color: index == 2 ? Colors.white : Colors.black),
              onPressed: () {}),
        ),
        Expanded(
          child: Divider(
            height: 5,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: RaisedButton(
              color: index == 3 ? colors : Colors.transparent,
              splashColor: Colors.blueAccent,
              shape: CircleBorder(),
              child: TextWidget(
                  txt: '4', color: index == 3 ? Colors.white : Colors.black),
              onPressed: () {}),
        ),
        Expanded(
          child: Divider(
            height: 5,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: RaisedButton(
              color: index == 4 ? colors : Colors.transparent,
              splashColor: Colors.blueAccent,
              shape: CircleBorder(),
              child: TextWidget(
                  txt: '5', color: index == 4 ? Colors.white : Colors.black),
              onPressed: () {}),
        ),
        Expanded(
          child: Divider(
            height: 5,
            indent: double.infinity,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  _visibleNavigation(bool next, bool back) {
    _visibleNext = next;
    _visibleBack = back;
  }

  _increaseTab() {
    setState(() {
      if (_indexStep < 4) {
        _indexStep++;
      }
    });
  }

  _decrease() {
    setState(() {
      if (_indexStep > 0) {
        _indexStep--;
      }
    });
  }

  _validatingStepTwo(String phone, String email, String reEmail) {
    if (phone.length < 10 || !validateEmail(email) || email != reEmail) {
      setState(() {
        _visibleNavigation(false, true);
      });
    } else {
      SharedPreferencesHelper.setPhone(phone);
      SharedPreferencesHelper.setEmail(email);
      setState(() {
        _visibleNavigation(true, true);
      });
    }
  }
}
