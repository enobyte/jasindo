import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/src/blocs/about_bloc.dart';
import 'package:jasindo_app/src/models/abouts_model.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class TermCondition extends StatefulWidget {
  AboutBloc blocAbout;

  @override
  State<StatefulWidget> createState() {
    return TermConditionState();
  }

  TermCondition(this.blocAbout);
}

class TermConditionState extends State<TermCondition> {
  AboutsModels models;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          title:
              Text("Syarat & Ketentuan", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Column(
            children: <Widget>[_title(), _content()],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return TextWidget(
      txt: titleTermCondition,
      color: blueStandart,
      txtSize: 25,
      align: TextAlign.left,
      fontFamily: 'SF-Bold',
    );
  }

  Widget _content() {
    return Container(child: Html(data: _getTerm()));
  }

  String _getTerm() {
    String description = "";
    if (models != null && models.data != null) {
      models.data.forEach((data) {
        if (data != null) {
          if (data.name == "termcondition") {
            setState(() {
              description = data.descriptions;
            });
          }
        } else {
          setState(() {
            description = "";
          });
        }
      });
    } else {
      description = "";
    }
    return description;
  }

  _fetchData() {
    widget.blocAbout
        .aboutBloc((status, message, models) => {_renderView(models)});
  }

  _renderView(AboutsModels aboutModel) async {
    setState(() {
      this.models = aboutModel;
    });
  }
}
