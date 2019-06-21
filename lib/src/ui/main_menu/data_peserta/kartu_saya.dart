import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/models/choose_dependent_model.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class CardMember extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardMemberState();
  }
}

class CardMemberState extends State<CardMember> {
  String _name,
      _email,
      _noCard,
      _corporate,
      _birthDate,
      _memberType,
      _policy,
      _level;
  List<String> _benefit = List();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _initView();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: new Stack(
          children: <Widget>[
            Container(
              child: _level == 'Y' ||
                      _corporate == 'JAMKESTAMA (VVIP)' ||
                      _corporate == 'JAMKESMEN (VVIP)'
                  ? Image.asset('lib/assets/images/vipcard.png')
                  : Image.asset('lib/assets/images/oricard.png'),
              alignment: Alignment(0.0, 0.0),
              color: Colors.white,
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: _level == 'Y' ||
                        _corporate == 'JAMKESTAMA (VVIP)' ||
                        _corporate == 'JAMKESMEN (VVIP)'
                    ? EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 5,
                        top: MediaQuery.of(context).size.width / 9,
                        right: MediaQuery.of(context).size.width / 4,
                      )
                    : EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 4.5,
                        top: MediaQuery.of(context).size.width / 10,
                        right: MediaQuery.of(context).size.width / 4,
                      ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      txtSize: 18,
                      txt: _name != null ? _name.toUpperCase().trim() : "",
                    ),
                    TextWidget(
                      txtSize: 12,
                      txt: _email,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _title(),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(child: valueMember())
                      ],
                    )
                  ],
                ))
          ],
        ),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(
          txtSize: 12,
          txt: 'No. Admedika',
        ),
        TextWidget(
          txtSize: 12,
          txt: 'Corporate',
        ),
        TextWidget(
          txtSize: 12,
          txt: 'Policy',
        ),
        TextWidget(
          txtSize: 12,
          txt: 'Date of birth',
        ),
        TextWidget(
          txtSize: 12,
          txt: 'Member Type',
        ),
        TextWidget(
          txtSize: 12,
          txt: 'Benefit',
        ),
      ],
    );
  }

  Widget valueMember() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(
          txtSize: 12,
          txt: _noCard,
        ),
        TextWidget(
          txtSize: 12,
          txt: _corporate != null ? _corporate.trim() : "",
        ),
        TextWidget(
          txtSize: 12,
          txt: _policy != null ? _policy.trim() : "",
        ),
        TextWidget(
          txtSize: 12,
          txt: _birthDate,
        ),
        TextWidget(
          txtSize: 12,
          txt: _memberType != null ? _memberType.trim() : "",
        ),
        TextWidget(
          align: TextAlign.start,
          maxLine: 2,
          txtSize: 10,
          txt: _benefit != null ? _benefit.join(",").trim() : "",
        ),
      ],
    );
  }

  _initView() {
    SharedPreferencesHelper.getDoLogin().then((member) {
      final memberModels = MemberModels.fromJson(json.decode(member));
      SharedPreferencesHelper.getPlans().then((plan) {
        final plansModel = GetPlansModel.fromJson(json.decode(plan));
        SharedPreferencesHelper.getDependent().then((dependent) {
          for (var item in plansModel.data) {
            _benefit.add(item.planType);
          }
          _level = memberModels.adcps.vip;
          if (dependent.isEmpty) {
            setState(() {
              _name = memberModels.data.name;
              _noCard = memberModels.data.cardNumb;
              _birthDate = memberModels.data.birthDate.substring(0, 10);
              _corporate = memberModels.adcps.corporateInfo;
              _email = memberModels.data.email;
              _memberType = memberModels.adcps.memberType;
              _policy = memberModels.adcps.policyNumber;
            });
          } else {
            final dependentModel =
                ChooseDependent.fromJson(json.decode(dependent));
            setState(() {
              _name = dependentModel.name;
              _noCard = dependentModel.cardNo;
              _birthDate =
                  '${dependentModel.bateOfBirth.split("-")[2]}-${mmmTomm(dependentModel.bateOfBirth.split("-")[0])}-${dependentModel.bateOfBirth.split("-")[1]}';
              _corporate = dependentModel.corporateInfo;
              _email = memberModels.data.email;
              _memberType = dependentModel.memberType;
              _policy = dependentModel.policyNumber;
            });
          }
        });
      });
    });
  }
}
