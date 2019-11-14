import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jasindo_app/src/blocs/notification_bloc.dart';
import 'package:jasindo_app/src/models/discharge_model.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/notification_model.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/Bubble.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class DischargeForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DischargeFormState();
  }
}

class DischargeFormState extends State<DischargeForm> {
  List<DischargeModel> data = [];
  String _noCard = '';

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.getDoLogin().then((onValue) {
      final memberModels = MemberModels.fromJson(json.decode(onValue));
      setState(() {
        _noCard = memberModels.data.cardNumb;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          StreamBuilder(
              stream: bloc.getNotifBloc,
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  data.add(DischargeModel.fromJson(
                      jsonDecoder(snapshot.data['data'])));
                  return Flexible(
                      child: ListView(
                    children: data
                        .map((f) => Container(
                              padding: const EdgeInsets.all(8.0),
                              child: BubbleMessage(
                                painter: Bubble(),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 250.0,
                                    minWidth: 50.0,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 6.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4, bottom: 4),
                                        child: TextWidget(
                                          align: TextAlign.left,
                                          txt: f.provider_name.toUpperCase(),
                                          txtSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextWidget(
                                        align: TextAlign.left,
                                        txt: f.message_desc,
                                        txtSize: 14,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: TextWidget(
                                          txtSize: 10,
                                          color: Colors.white,
                                          align: TextAlign.right,
                                          txt: new DateFormat(
                                                  "dd MMM yyyy HH:mm")
                                              .format(DateTime.now()),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ));
                } else if (snapshot.hasError) {
                  return TextWidget(
                    txt: snapshot.error.toString(),
                  );
                }
                return Flexible(
                    child: ListView(
                  children: <Widget>[Container()],
                ));
              }),
          new Divider(
            height: 1.0,
          ),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _chatEnvironment(),
          )
        ],
      ),
    );
  }

  Widget _chatEnvironment() {
    return IconTheme(
      data: new IconThemeData(color: Colors.red),
      child: new Container(
        width: double.infinity,
        color: Color(0xFFC62828),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        child: new FlatButton(
          child: TextWidget(
            txt: 'DISCHARGE',
            color: Colors.white,
          ),
          onPressed: () =>
              data[data.length - 1].is_active == "Y" && data.length > 0
                  ? _handleSubmit()
                  : null,
        ),
      ),
    );
  }

  void _handleSubmit() {
    bloc.buttonDischargeBloc(_noCard);
  }
}
