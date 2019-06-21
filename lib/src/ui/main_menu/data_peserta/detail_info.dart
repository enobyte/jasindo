import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/getdependent_bloc.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/getplans_bloc.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/models/choose_dependent_model.dart';
import 'package:jasindo_app/src/models/dependent_model.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/requests/do_req_dependent.dart';
import 'package:jasindo_app/src/models/requests/do_req_plans.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ImageCircle.dart';
import 'package:jasindo_app/widgets/ImageCover.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class DetailInfoPeserta extends StatefulWidget {
  List<String> plans;
  String polisPeriod;

  @override
  State<StatefulWidget> createState() {
    return DetailInfoPesertaState();
  }

  DetailInfoPeserta({this.plans, this.polisPeriod});
}

class DetailInfoPesertaState extends State<DetailInfoPeserta> {
  String _noCard,
      _corporate,
      _level,
      _typeMember,
      _policy,
      _dateBirth,
      _name,
      _dateBirtRequest,
      _noCardRequest,
      _namePrinciple,
      _employId;
  final bloc = GetDependentBloc();
  final blocPlan = GetPlansBloc();

  DependentModels model;
  GetPlansModel plansModel;

  @override
  void initState() {
    _checkDependent();
    super.initState();
  }

  int isSelected = -1;

  _isSelected(int index) {
    isSelected = index;
    _showDependent(model);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false, //disable back button
          backgroundColor: Colors.transparent,
          expandedHeight: MediaQuery.of(context).size.height / 3,
          flexibleSpace: FlexibleSpaceBar(background: _header()),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Divider(
                color: Colors.transparent,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Perusahaan', color: Colors.blue),
                    TextWidget(txt: _corporate)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Level', color: Colors.blue),
                    TextWidget(
                        txt: _level == 'Y' ||
                                _corporate == 'JAMKESTAMA (VVIP)' ||
                                _corporate == 'JAMKESMEN (VVIP)'
                            ? 'VVIP'
                            : 'NON VVIP')
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'No Kartu', color: Colors.blue),
                    TextWidget(txt: _noCard)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Tipe Peserta', color: Colors.blue),
                    TextWidget(txt: _typeMember)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Policy', color: Colors.blue),
                    TextWidget(txt: _policy)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Tanggal Lahir', color: Colors.blue),
                    TextWidget(txt: _dateBirth)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    TextWidget(txt: 'Manfaat', color: Colors.blue),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: TextWidget(
                        align: TextAlign.right,
                        txt: widget.plans.join(', '),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWidget(txt: 'Periode Polis', color: Colors.blue),
                    TextWidget(txt: widget.polisPeriod)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Stack(fit: StackFit.expand, children: <Widget>[
      ImageCover(false, 'lib/assets/images/background_peserta.png'),
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 5),
            ImageCircle(
                true,
                'https://static.stayjapan.com/assets/user_no_photo-4896a2d64d70a002deec3046d0b6ea6e7f01628781493566c95a02361524af97.png',
                80),
            Spacer(flex: 1),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: TextWidget(
                    txt: _name,
                    color: Colors.white,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _level == 'Y' ||
                            _corporate == 'JAMKESTAMA (VVIP)' ||
                            _corporate == 'JAMKESMEN (VVIP)'
                        ? Image.asset(
                            'lib/assets/images/ic_vip.png',
                            height: 20,
                          )
                        : Container())
              ],
            ),
            Spacer(flex: 1),
            FlatButton.icon(
              color: Colors.white,
              onPressed: () => {
                    _fetchDependent(),
                  },
              icon: Image.asset(
                'lib/assets/images/ic_family.png',
                height: 15,
              ),
              label: TextWidget(
                txt: 'Akun Keluarga',
              ),
            ),
            Spacer(flex: 5),
          ],
        ),
      )
    ]);
  }

  _initView() {
    SharedPreferencesHelper.getDoLogin().then((onValue) {
      final memberModels = MemberModels.fromJson(json.decode(onValue));
      setState(() {
        _name = memberModels.data.name;
        _namePrinciple = memberModels.data.name;
        _noCard = memberModels.data.cardNumb;
        _noCardRequest = memberModels.data.cardNumb;
        _corporate = memberModels.adcps.corporateInfo;
        _level = memberModels.adcps.vip;
        _typeMember = memberModels.adcps.memberType;
        _policy = memberModels.adcps.policyNumber.replaceAll(" ", "");
        _dateBirth =
            formatDateFormStandart(memberModels.data.birthDate, "dd MMMM yyyy");
        _dateBirtRequest =
            formatDateFormStandart(memberModels.data.birthDate, "yyyy-MM-dd");
        _employId = memberModels.adcps.employeeId;
      });
    });
  }

  Future<void> _showDependent(DependentModels model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'lib/assets/images/ic_family.png',
                  height: 50,
                ),
              ),
              TextWidget(
                txt: 'KARYAWAN',
                align: TextAlign.center,
                fontFamily: 'SF-Semibold',
              ),
              Container(
                  margin: EdgeInsets.only(top: 4),
                  padding: EdgeInsets.all(4),
                  width: double.infinity,
                  color: Colors.grey,
                  child: TextWidget(
                    txt: _namePrinciple,
                    align: TextAlign.center,
                    color: Colors.white,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextWidget(
                  txt: 'KELUARGA',
                  fontFamily: 'SF-Semibold',
                  align: TextAlign.center,
                ),
              ),
              Container(
                  height: 150.0,
                  width: double.maxFinite,
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => {
                                  Navigator.of(context).pop(),
                                  _isSelected(index)
                                },
                            child: Container(
                                margin: EdgeInsets.all(4),
                                padding: EdgeInsets.all(4),
                                color: isSelected != null &&
                                        isSelected ==
                                            index //set condition like this. voila! if isSelected and list index matches it will colored as white else orange.
                                    ? Colors.brown
                                    : Colors.orange,
                                child: TextWidget(
                                  txt: model.data[index].name,
                                  color: Colors.white,
                                )));
                      },
                      itemCount: model.data.length)),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('BATAL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('GANTI'),
              onPressed: () {
                SharedPreferencesHelper.setDependent(
                    json.encode(this.model.data[isSelected]));
                SharedPreferencesHelper.getDependent().then((onValue) {
                  final dependentModel =
                      ChooseDependent.fromJson(json.decode(onValue));
                  setState(() {
                    _name = dependentModel.name;
                    _noCard = dependentModel.cardNo;
                    _corporate = dependentModel.corporateInfo;
                    _typeMember = dependentModel.memberType;
                    _policy = dependentModel.policyNumber
                        .toString()
                        .replaceAll(" ", "");
                    _dateBirth = dependentModel.bateOfBirth;
                  });
                  _fetchPlan();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  _fetchDependent() {
    isSelected = -1;
    ReqGetDependent request = ReqGetDependent(
        cardNumber: _noCardRequest,
        birthDate: _dateBirtRequest,
        employeeId: _employId.replaceAll(" ", ""));
    bloc.fetchDependent(request.toMap(),
        (model, status, message) => {_renderView(model, status, message)});
  }

  _renderView(DependentModels model, bool status, String message) {
    if (status) {
      this.model = model;
      _showDependent(model);
    }
  }

  _fetchPlan() {
    ReqGetPlan request = ReqGetPlan(
        cardNumber: _noCard,
        birthDate:
            '${_dateBirth.split("-")[2]}-${mmmTomm(_dateBirth.split("-")[0])}-${_dateBirth.split("-")[1]}');
    blocPlan.fetchGetPlans(request.toMap(), (status, message) {
      SharedPreferencesHelper.getPlans().then((onValue) {
        plansModel = GetPlansModel.fromJson(json.decode(onValue));
        widget.plans.clear();
        setState(() {
          for (var item in plansModel.data) {
            widget.plans.add(item.planType);
          }
          widget.polisPeriod =
              plansModel.data[0].policyStartDate.replaceAll("-", "/") +
                  ' - ' +
                  plansModel.data[0].policyEndDate.replaceAll("-", "/");
        });
      });
    });
  }

  _checkDependent() {
    SharedPreferencesHelper.getDependent().then((onValue) {
      if (onValue.isEmpty) {
        _initView();
      } else {
        final dependentModel = ChooseDependent.fromJson(json.decode(onValue));
        SharedPreferencesHelper.getDoLogin().then((member) {
          final memberModels = MemberModels.fromJson(json.decode(member));
          setState(() {
            _noCardRequest = memberModels.data.cardNumb;
            formatDateFormStandart(memberModels.data.birthDate, "dd MMMM yyyy");
            _dateBirtRequest = formatDateFormStandart(
                memberModels.data.birthDate, "yyyy-MM-dd");
            _employId = memberModels.adcps.employeeId;
            _namePrinciple = memberModels.data.name;
            _level = memberModels.adcps.vip;

            _name = dependentModel.name;
            _noCard = dependentModel.cardNo;
            _corporate = dependentModel.corporateInfo;
            _typeMember = dependentModel.memberType;
            _policy =
                dependentModel.policyNumber.toString().replaceAll(" ", "");
            _dateBirth = dependentModel.bateOfBirth;
          });
        });
      }
    });
  }
}
