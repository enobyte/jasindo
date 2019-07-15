import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/messages_bloc.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/requests/do_req_messages.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class JasindoContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return JasindoContactState();
  }
}

class JasindoContactState extends State<JasindoContact> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _validateCard = false;
  final bloc = MessagesBloc();
  final _scaffolKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolKey,
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        title: TextWidget(txt: "Kontak Jasindo", color: blueStandart),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[_subject(), _Messages()],
          ),
        ),
      ),
    );
  }

  Widget _subject() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            labelText: "Subject",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            errorText: _validateCard ? "Pastikan subject terisi" : null),
        controller: _subjectController,
      ),
    );
  }

  Widget _Messages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
            child: TextWidget(txt: 'Pesan anda')),
        Container(
          margin: EdgeInsets.fromLTRB(40.0, 4.0, 40.0, 0.0),
          child: TextField(
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                errorText: _validateCard ? "Pastikan pesan terisi" : null),
            controller: _messageController,
          ),
        ),
        _send()
      ],
    );
  }

  Widget _send() {
    return Container(
      padding: EdgeInsets.only(right: 60, left: 60, top: 20),
      child: ButtonWidget(
          height: 50,
          txtSize: 14,
          txtColor: Colors.white,
          txt: 'KIRIM',
          btnColor: blueStandart,
          borderRedius: 5,
          onClick: () => {_onSubmit()}),
    );
  }

  _onSubmit() {
    SharedPreferencesHelper.getDoLogin().then((onValue) {
      final memberModels = MemberModels.fromJson(json.decode(onValue));
      ReqMessages reqMessages = ReqMessages(
          email: memberModels.data.email,
          subject: _subjectController.text,
          messages: _messageController.text);
      bloc.messageBloc(reqMessages.toMap(), (status, message) {
        _showNotif(status, message);
      });
    });
  }

  _showNotif(bool status, String message) {
    _scaffolKey.currentState.showSnackBar(SnackBar(
        content: TextWidget(
      txt: message,
    )));
  }
}
