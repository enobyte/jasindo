import 'package:flutter/material.dart';
import 'package:jasindo_app/src/ui/registration/step_five.dart';
import 'package:jasindo_app/src/ui/registration/step_four.dart';
import 'package:jasindo_app/src/ui/registration/step_one.dart';
import 'package:jasindo_app/src/ui/registration/step_three.dart';
import 'package:jasindo_app/src/ui/registration/step_two.dart';
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

  @override
  Widget build(BuildContext context) {
    print(_indexStep);
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("DAFTAR", style: TextStyle(color: Colors.black)),
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
                  fillColor: Colors.green,
                  elevation: 0,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.arrow_back_ios),
                      Text('BACK'),
                    ],
                  ),
                  onPressed: () =>
                  {
                    _decrease()
                  },
                ),
              ),
              Visibility(
                visible: _visibleNext,
                child: RawMaterialButton(
                  fillColor: Colors.blue,
                  elevation: 0,
                  child: Row(
                    children: <Widget>[
                      Text('NEXT'),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  onPressed: () =>
                  {
                    _increaseTab()
                  },
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
        _widget = StepOne(() =>
        {
          _increaseTab()
        });
        break;
      case 1:
        setState(() {
          _visibleNavigation(true, true);
        });
        _widget = StepTwo();
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
          code: randomString(),
          onClickRegister: () =>
          {
            _increaseTab()
          },
        );
        break;
      case 4:
        setState(() {
          _visibleNavigation(false, false);
        });
        _widget = StepFive();
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

  _decrease(){
    setState(() {
      if (_indexStep > 0) {
        _indexStep--;
      }
    });
  }
}

