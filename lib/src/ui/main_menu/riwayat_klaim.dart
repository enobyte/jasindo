import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/gethistoryclaim_bloc.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/getplans_bloc.dart';
import 'package:jasindo_app/src/models/adcps/get_hist_claim.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/models/choose_dependent_model.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/requests/do_req_histclaim.dart';
import 'package:jasindo_app/src/models/requests/do_req_plans.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RiwayatKlaim extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RiwayatKlaimState();
  }
}

class RiwayatKlaimState extends State<RiwayatKlaim> {
  final bloc = GetHistoryClaimBloc();
  final planbloc = GetPlansBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final currancy = new NumberFormat("#,##0.00", "en_US");
  String _planId,
      _cardNumber,
      _birthDate,
      _claimType,
      _planType,
      valueDateStart,
      valueDateEnd;
  GetPlansModel plansModel = GetPlansModel();
  GetHistClaimModel claimModel = GetHistClaimModel();
  List<String> listTypeClaim = new List();
  bool isLoadingClaim = false, isRangeDate = false;
  DateTime selectedDateEnd = DateTime.now();
  DateTime selectedDateStart = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchPlan();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    planbloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        title: TextWidget(txt: "Riwayat Klaim", color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[_searchList(), _sortirList()],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[_klaimList(), _rangeTimeList()],
                  ),
                )
              ],
            ),
          ),
          _listHistoryClaim()
        ],
      ),
    );
  }

  Widget _searchList() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        height: 40,
        alignment: FractionalOffset.center,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, style: BorderStyle.solid, color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text('SEMUA JAMINAN'),
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                setState(() {
                  _planId = newValue;
                  _claimType = null;
                  isLoadingClaim = true;
                });
                ReqGetHistClaim request = ReqGetHistClaim(
                    cardNumber: _cardNumber,
                    birthDate: _birthDate,
                    planId: _planId);
                bloc.fetchHistClaim(
                    request.toMap(),
                    (callback, status, message) => {
                          _collectHistoryClaim(callback, status, message),
                        });
              });
            },
            value: _planId,
            items: plansModel.data == null
                ? List<String>().map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList()
                : plansModel.data.map<DropdownMenuItem<String>>((value) {
                    _planType = value.planType;
                    return DropdownMenuItem(
                        value: value.planId, child: Text(value.planType));
                  }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _klaimList() {
    return Expanded(
      child: claimModel.data != null && claimModel.data.length > 0
          ? Container(
              margin: EdgeInsets.all(10),
              height: 40,
              alignment: FractionalOffset.center,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      style: BorderStyle.solid,
                      color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('TIPE KLAIM'),
                  isExpanded: true,
                  onChanged: (newValue) {
                    setState(() {
                      _claimType = newValue;
                    });
                  },
                  value: _claimType,
                  items: claimModel.data[0].responseCode != "200"
                      ? List<String>().map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList()
                      : listTypeClaim.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                ),
              ),
            )
          : Container(),
    );
  }

  Widget _sortirList() {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => {_setSorting(claimModel)},
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 60,
                  child: Text(
                    'Sortir Tanggal',
                    maxLines: 2,
                  ),
                ),
                Image.asset(
                  'lib/assets/images/ic_sorting.png',
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rangeTimeList() {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => {showTime()},
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 60,
                  child: Text(
                    'Rentang Waktu',
                    maxLines: 2,
                  ),
                ),
                Image.asset(
                  'lib/assets/images/ic_date.png',
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listHistoryClaim() {
    return StreamBuilder(
        stream: bloc.getHistClaim,
        builder: (context, AsyncSnapshot<GetHistClaimModel> snapshot) {
          if (snapshot.hasData &&
              snapshot.data.data != null &&
              !isLoadingClaim) {
            return Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    _claimType == null
                        ? _listHistoryClaimContent(snapshot, index)
                        : snapshot.data.data[index].claimType
                                .toLowerCase()
                                .contains(_claimType.toLowerCase())
                            ? _listHistoryClaimContent(snapshot, index)
                            : Container(),
                itemCount: snapshot.data.data.length,
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return isLoadingClaim
              ? Center(child: CircularProgressIndicator())
              : Container();
        });
  }

  Widget _listHistoryClaimContent(
      AsyncSnapshot<GetHistClaimModel> snapshot, int index) {
    try {
      if (isRangeDate && snapshot.data.data[index].admissionDate.isNotEmpty) {
        final filter = snapshot;
        filter.data.data = filter.data.data
            .where((i) =>
                DateTime.parse(i.admissionDate).isAfter(selectedDateStart) &&
                DateTime.parse(i.admissionDate).isBefore(selectedDateEnd))
            .toList();
        return filter.data.data.length > 0 &&
                filter.data.data[0].responseCode == "200"
            ? Card(
                margin: EdgeInsets.all(5),
                elevation: 4,
                shape: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                child: Column(
                  children: <Widget>[
                    _claimContentTop(filter, index),
                    _claimContentMiddle(filter, index),
                    _claimContentBottom(filter, index),
                  ],
                ))
            : Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                child: Container(
                  child: Image.asset(
                    'lib/assets/images/not_found.png',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                ),
              );
      } else {
        return snapshot.data.data.length > 0 &&
                snapshot.data.data[0].responseCode == "200"
            ? Card(
                margin: EdgeInsets.all(5),
                elevation: 4,
                shape: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                child: Column(
                  children: <Widget>[
                    _claimContentTop(snapshot, index),
                    _claimContentMiddle(snapshot, index),
                    _claimContentBottom(snapshot, index),
                  ],
                ))
            : Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                child: Container(
                  child: Image.asset(
                    'lib/assets/images/not_found.png',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                ),
              );
      }
    } catch (e, stack) {
      print(stack.toString());
    }
  }

  Widget _claimContentTop(
      AsyncSnapshot<GetHistClaimModel> snapshot, int index) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextWidget(
                        txt: 'CLAIM ID',
                        txtSize: 10,
                        color: Colors.blue,
                        align: TextAlign.left,
                      ),
                      Spacer(flex: 12),
                      TextWidget(
                        txt: snapshot.data.data[index].claimId,
                        txtSize: 10,
                        align: TextAlign.left,
                      ),
                      Spacer(flex: 10),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextWidget(
                        txt: 'STATUS',
                        txtSize: 10,
                        color: Colors.blue,
                        align: TextAlign.left,
                      ),
                      Spacer(flex: 20),
                      TextWidget(
                        txt: snapshot.data.data[index].status,
                        txtSize: 10,
                        align: TextAlign.left,
                      ),
                      Spacer(flex: 12),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Table(
              children: [
                TableRow(children: [
                  TextWidget(
                    txt: 'PROVIDER',
                    txtSize: 10,
                    color: Colors.blue,
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    txt: snapshot.data.data[index].providerName,
                    txtSize: 10,
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    txt: 'CLAIM TYPE',
                    txtSize: 10,
                    color: Colors.blue,
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    txt: snapshot.data.data[index].claimType,
                    txtSize: 10,
                    align: TextAlign.left,
                  ),
                ]),
                TableRow(children: [
                  TextWidget(
                    txt: 'ADMISSION',
                    txtSize: 10,
                    color: Colors.blue,
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    txt: formatDateFormStandart(
                        snapshot.data.data[index].admissionDate, 'MMM/dd/yyyy'),
                    txtSize: 10,
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    txt: 'BENEFIT',
                    txtSize: 10,
                    color: Colors.blue,
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    txt: _planType,
                    txtSize: 10,
                    align: TextAlign.left,
                  ),
                ]),
                //SizedBox(width: 8),
                TableRow(children: [
                  TextWidget(
                    txt: 'DISCHARGE',
                    txtSize: 10,
                    color: Colors.blue,
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    txt: formatDateFormStandart(
                        snapshot.data.data[index].dischargeDate, 'MMM/dd/yyyy'),
                    txtSize: 10,
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    txt: 'DIAGNOSIS',
                    txtSize: 10,
                    color: Colors.blue,
                    align: TextAlign.left,
                  ),
                  TextWidget(
                    txt: snapshot.data.data[index].diagnosis,
                    txtSize: 10,
                    align: TextAlign.left,
                  ),
                ])
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 10),
                child: Divider(
                  height: 2,
                )),
          ],
        ));
  }

  Widget _claimContentMiddle(
      AsyncSnapshot<GetHistClaimModel> snapshot, int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextWidget(txt: 'INCURED', txtSize: 10, color: Colors.blue),
                  TextWidget(
                      txt: 'Rp. ' +
                          currancy.format(
                              int.parse(snapshot.data.data[index].incured)),
                      txtSize: 10),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextWidget(txt: 'APPROVED', txtSize: 10, color: Colors.blue),
                  TextWidget(
                      txt: 'Rp. ' +
                          currancy.format(
                              int.parse(snapshot.data.data[index].approved)),
                      txtSize: 10),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextWidget(txt: 'EXCESS', txtSize: 10, color: Colors.blue),
                  TextWidget(
                      txt: 'Rp. ' +
                          currancy.format(
                              int.parse(snapshot.data.data[index].excess)),
                      txtSize: 10),
                ],
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Divider(
                height: 2,
              )),
        ],
      ),
    );
  }

  Widget _claimContentBottom(
      AsyncSnapshot<GetHistClaimModel> snapshot, int index) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextWidget(txt: 'REMARK', txtSize: 10, color: Colors.blue),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextWidget(
              txt: snapshot.data.data[index].remarks,
              align: TextAlign.left,
              txtSize: 10,
            ),
          )
        ],
      ),
    );
  }

  _fetchPlan() {
    setState(() {
      isLoadingClaim = false;
    });
    SharedPreferencesHelper.getDependent().then((dependent) {
      if (dependent.isEmpty) {
        SharedPreferencesHelper.getDoLogin().then((onValue) {
          final memberModels = MemberModels.fromJson(json.decode(onValue));
          _cardNumber = memberModels.data.cardNumb;
          _birthDate = memberModels.data.birthDate.substring(0, 10);
          _attemptGetPlan(_cardNumber, _birthDate);
        });
      } else {
        final dependentModel = ChooseDependent.fromJson(json.decode(dependent));
        _cardNumber = dependentModel.cardNo;
        _birthDate =
            '${dependentModel.bateOfBirth.split("-")[2]}-${mmmTomm(dependentModel.bateOfBirth.split("-")[0])}-${dependentModel.bateOfBirth.split("-")[1]}';
        _attemptGetPlan(_cardNumber, _birthDate);
      }
    });
  }

  _attemptGetPlan(String cardNumber, String birthDate) {
    ReqGetPlan request =
        ReqGetPlan(cardNumber: cardNumber, birthDate: birthDate);
    ReqGetHistClaim requestClaim = ReqGetHistClaim(
        cardNumber: _cardNumber,
        birthDate: _birthDate,
        planId: _planId,
        limit: "ALL");
    planbloc.fetchGetPlans(request.toMap(), (status, message) {
      SharedPreferencesHelper.getPlans().then((onValue) {
        plansModel = GetPlansModel.fromJson(json.decode(onValue));
        setState(() {
          isLoadingClaim = true;
        });
        bloc.fetchHistClaim(
            requestClaim.toMap(),
            (callback, status, message) => {
                  _collectHistoryClaim(callback, status, message),
                });
      });
      if (!status) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(message)));
      }
    });
  }

  _collectHistoryClaim(
      GetHistClaimModel callback, bool status, String message) {
    if (status) {
      claimModel = callback;
      _collectClaimType(callback);
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
    }
    setState(() {
      isRangeDate = false;
      isLoadingClaim = false;
    });
  }

  _collectClaimType(GetHistClaimModel callback) {
    listTypeClaim.clear();
    callback.data.forEach((data) => {listTypeClaim.add(data.claimType)});
    listTypeClaim = listTypeClaim.toSet().toList();
  }

  showTime() {
    Alert(
        context: context,
        title: "Rentang Waktu",
        content: Column(
          children: <Widget>[
            InkWell(
              onTap: () => {_selectStartDate(context)},
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(labelText: 'Start'),
                initialValue: valueDateStart,
              ),
            ),
            InkWell(
              onTap: () => {_selectEndDate(context)},
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(labelText: 'End'),
                initialValue: valueDateEnd,
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () =>
                {_findBetweenDate(claimModel), Navigator.pop(context)},
            child: Text(
              "SUBMIT",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateEnd,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateEnd) selectedDateEnd = picked;
    _showDateEnd(selectedDateEnd);
  }

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateStart,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateStart)
      selectedDateStart = picked;
    _showDateStart(selectedDateStart);
  }

  _showDateEnd(DateTime date) {
    valueDateEnd = "${date.day}-${date.month}-${date.year}";
    Navigator.of(context).pop();
    showTime();
  }

  _showDateStart(DateTime date) {
    valueDateStart = "${date.day}-${date.month}-${date.year}";
    Navigator.of(context).pop();
    showTime();
  }

  _findBetweenDate(GetHistClaimModel snapshot) {
    ReqGetHistClaim request;
    if (_planId == null) {
      request = ReqGetHistClaim(
          cardNumber: _cardNumber,
          birthDate: _birthDate,
          planId: _planId,
          limit: "ALL");
    } else {
      request = ReqGetHistClaim(
          cardNumber: _cardNumber, birthDate: _birthDate, planId: _planId);
    }
    bloc.fetchHistClaim(
        request.toMap(),
        (callback, status, message) =>
            {claimModel = callback, isLoadingClaim = false});
    setState(() {
      isRangeDate = true;
      isLoadingClaim = true;
    });
  }

  _setSorting(GetHistClaimModel snapshot) {
    setState(() {
      claimModel.data = snapshot.data
        ..sort((a, b) =>
            int.parse(formatDateFormStandart(a.admissionDate, 'yyyyMMdd'))
                .compareTo(int.parse(
                    formatDateFormStandart(b.admissionDate, 'yyyyMMdd'))));
    });
  }
}
