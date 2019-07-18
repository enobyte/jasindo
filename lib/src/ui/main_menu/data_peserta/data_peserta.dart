import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/getplans_bloc.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/models/choose_dependent_model.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/requests/do_req_plans.dart';
import 'package:jasindo_app/src/ui/main_menu/data_peserta/detail_info.dart';
import 'package:jasindo_app/src/ui/main_menu/data_peserta/manfaat_jaminan.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/BubbleTabIndicator.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

import 'kartu_saya.dart';

class DataPeserta extends StatefulWidget {
  DataPeserta({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DataPesertaState();
  }
}

class DataPesertaState extends State<DataPeserta>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(text: "Kepesertaan"),
    new Tab(text: "Manfaat & Jaminan"),
    new Tab(text: "Kartu Saya")
  ];

  TabController _tabController;
  final bloc = GetPlansBloc();
  List<String> listManfaat = new List();
  String polishPeriod, cardNumber, birthDate;

  GetPlansModel plansModel;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
    _tabController.addListener(_tabListener);
    _fetchPlan();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        title: TextWidget(txt: "Data Peserta", color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BubbleTabIndicator(
            indicatorHeight: 25.0,
            indicatorColor: Colors.blueAccent,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: _tabController,
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: tabs
            .asMap()
            .map((index, tab) => MapEntry(
                index,
                Container(
                  child: _contentPage(index),
                )))
            .values
            .toList(),
      ),
    );
  }

  // ignore: missing_return
  Widget _contentPage(int index) {
    switch (index) {
      case 0:
        return DetailInfoPeserta(
          plans: listManfaat,
          polisPeriod: polishPeriod,
        );
        break;
      case 1:
        return BenefitGuaranty(
          cardNumber: cardNumber,
          birthDate: birthDate,
          plans: plansModel,
        );
        break;
      case 2:
        return CardMember();
        break;
    }
  }

  _fetchPlan() {
    SharedPreferencesHelper.getDependent().then((dependent) {
      if (dependent.isEmpty) {
        SharedPreferencesHelper.getDoLogin().then((onValue) {
          final memberModels = MemberModels.fromJson(json.decode(onValue));
          cardNumber = memberModels.data.cardNumb;
          birthDate = memberModels.data.birthDate.substring(0, 10);
          _attemptPlan(cardNumber, birthDate);
        });
      } else {
        final dependentModel = ChooseDependent.fromJson(json.decode(dependent));
        cardNumber = dependentModel.cardNo;
        birthDate =
            '${dependentModel.bateOfBirth.split("-")[2]}-${mmmTomm(dependentModel.bateOfBirth.split("-")[0])}-${dependentModel.bateOfBirth.split("-")[1]}';
        _attemptPlan(cardNumber, birthDate);
      }
    });
  }

  _attemptPlan(String cardNumber, String birthDate) {
    ReqGetPlan request =
        ReqGetPlan(cardNumber: cardNumber, birthDate: birthDate);
    bloc.fetchGetPlans(request.toMap(), (status, message) {
      SharedPreferencesHelper.getPlans().then((onValue) {
        plansModel = GetPlansModel.fromJson(json.decode(onValue));
        setState(() {
          for (var item in plansModel.data) {
            listManfaat.add(item.planId.trim());
          }
          polishPeriod = formatDate(
                  '${plansModel.data[0].policyStartDate.split("-")[2]}${mmmTomm(plansModel.data[0].policyStartDate.split("-")[0])}${plansModel.data[0].policyStartDate.split("-")[1]}',
                  'dd-MM-yyyy') +
              ' - ' +
              formatDate(
                  '${plansModel.data[0].policyEndDate.split("-")[2]}${mmmTomm(plansModel.data[0].policyEndDate.split("-")[0])}${plansModel.data[0].policyEndDate.split("-")[1]}',
                  'dd-MM-yyyy');
        });
      });
    });
  }

  _tabListener() async {
    if (_tabController.index == 1) {
      SharedPreferencesHelper.getDependent().then((dependent) {
        if (dependent.isNotEmpty) {
          final dependentModel =
              ChooseDependent.fromJson(json.decode(dependent));
          setState(() {
            cardNumber = dependentModel.cardNo;
            birthDate =
                '${dependentModel.bateOfBirth.split("-")[2]}-${mmmTomm(dependentModel.bateOfBirth.split("-")[0])}-${dependentModel.bateOfBirth.split("-")[1]}';
          });

          SharedPreferencesHelper.getPlans().then((plan) {
            setState(() {
              plansModel = GetPlansModel.fromJson(json.decode(plan));
            });
          });
        } else {
          SharedPreferencesHelper.getDoLogin().then((onValue) {
            final memberModels = MemberModels.fromJson(json.decode(onValue));
            setState(() {
              cardNumber = memberModels.data.cardNumb;
              birthDate = memberModels.data.birthDate.substring(0, 10);
            });

            SharedPreferencesHelper.getPlans().then((plan) {
              setState(() {
                plansModel = GetPlansModel.fromJson(json.decode(plan));
              });
            });
          });
        }
      });
    }
  }
}
