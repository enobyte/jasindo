import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/gethistoryclaim_bloc.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/getplans_bloc.dart';
import 'package:jasindo_app/src/models/adcps/get_hist_claim.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/requests/do_req_histclaim.dart';
import 'package:jasindo_app/src/models/requests/do_req_plans.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class RiwayatKlaim extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RiwayatKlaimState();
  }
}

class RiwayatKlaimState extends State<RiwayatKlaim> {
  final bloc = GetHistoryClaimBloc();
  final planbloc = GetPlansBloc();
  String _planId, _cardNumber, _birthDate, _claimId, _planType;
  GetPlansModel plansModel = GetPlansModel();
  GetHistClaimModel claimModel = GetHistClaimModel();
  bool isLoadingClaim = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final currancy = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    _fetchPlan();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
      child: claimModel.data != null && claimModel.data[0].responseCode == "200"
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
                      _claimId = newValue;
                    });
                  },
                  value: _claimId,
                  items: claimModel.data[0].responseCode != "200"
                      ? List<String>().map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList()
                      : claimModel.data.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                              value: value.claimId,
                              child: Text(value.claimType + ' (${value.claimId})'));
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
          Row(
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
            onTap: () => {debugPrint('klik rentang waktu')},
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
          if (snapshot.hasData && snapshot.data.data != null) {
            return Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    _listHistoryClaimContent(snapshot, index),
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
    return snapshot.data.data[0].responseCode == "200"
        ? Card(
            margin: EdgeInsets.all(5),
            elevation: 4,
            shape: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)),
            child: Column(
              children: <Widget>[
                _claimContentTop(snapshot, index),
                _claimContentMiddle(snapshot, index),
                _claimContentBottom(snapshot, index)
              ],
            ))
        : Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
            child: Container(
              child: Image.asset(
                'lib/assets/images/not_found.png',
                height: MediaQuery.of(context).size.height / 3,
              ),
            ),
          );
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
                    txt: formatDateFormStandart(snapshot.data.data[index].admissionDate, 'MMM/dd/yyyy'),
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
                    txt: formatDateFormStandart(snapshot.data.data[index].dischargeDate, 'MMM/dd/yyyy'),
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
    SharedPreferencesHelper.getDoLogin().then((onValue) {
      final memberModels = MemberModels.fromJson(json.decode(onValue));
      _cardNumber = memberModels.data.cardNumb;
      _birthDate = memberModels.data.birthDate.substring(0, 10);
      ReqGetPlan request =
          ReqGetPlan(cardNumber: _cardNumber, birthDate: _birthDate);
      planbloc.fetchGetPlans(request.toMap(), (status, message) {
        SharedPreferencesHelper.getPlans().then((onValue) {
          plansModel = GetPlansModel.fromJson(json.decode(onValue));
          setState(() {});
        });
        if (!status) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(message)));
        }
      });
    });
  }

  _collectHistoryClaim(
      GetHistClaimModel callback, bool status, String message) {
    if (status) {
      claimModel = callback;
      setState(() {});
    } else {
      setState(() {
        isLoadingClaim = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
