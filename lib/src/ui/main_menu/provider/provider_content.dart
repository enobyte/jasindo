import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/getprovider_bloc.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/models/adcps/get_provider.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/requests/do_req_provider.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class ProviderContent extends StatefulWidget {
  List<String> listCity;
  String cityValue, planId;
  GetPlansModel plansModel;

  @override
  State<StatefulWidget> createState() {
    return ProviderContentState();
  }

  ProviderContent(
      {this.listCity, this.plansModel, this.cityValue, this.planId});
}

class ProviderContentState extends State<ProviderContent> {
  String changeCity = "", changePlan = "";
  GetProviderModel providerModel;
  final _searchController = TextEditingController();
  final bloc = GetProviderBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProvidder();
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
        title: TextWidget(txt: "Provider Rekanan", color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_topContent(), _listAction()],
        ),
      ),
    );
  }

  Widget _topContent() {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[_searchCity(), _searchJaminan(), _btnSubmit()],
          ),
          Row(
            children: <Widget>[_searchAny(), _buttonNearMe(), _buttonReset()],
          )
        ],
      ),
    );
  }

  Widget _searchCity() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      height: 40,
      width: MediaQuery.of(context).size.width / 3,
      alignment: FractionalOffset.center,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              widget.cityValue = newValue;
              changeCity = newValue;
            });
          },
          value: changeCity == "" ? widget.cityValue : changeCity,
          items: widget.listCity.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(
                value: value,
                child: TextWidget(
                  txt: value,
                  txtSize: 12,
                  maxLine: 1,
                  align: TextAlign.left,
                ));
          }).toList(),
        ),
      ),
    );
  }

  Widget _searchJaminan() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      height: 40,
      width: MediaQuery.of(context).size.width / 3,
      alignment: FractionalOffset.center,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              widget.planId = newValue;
              changePlan = newValue;
            });
          },
          value: changePlan == "" ? widget.planId : changePlan,
          items: widget.plansModel.data.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(
                value: value.planId,
                child: TextWidget(
                  txt: value.planType,
                  txtSize: 12,
                  maxLine: 1,
                  align: TextAlign.left,
                ));
          }).toList(),
        ),
      ),
    );
  }

  Widget _btnSubmit() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: RaisedButton(
          color: orangeColor2,
          onPressed: () => {
                _fetchProvidder(),
              },
          child: TextWidget(
            txt: 'SUBMIT',
            txtSize: 10,
            color: Colors.white,
          )),
    ));
  }

  Widget _searchAny() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      width: MediaQuery.of(context).size.width / 2,
      alignment: FractionalOffset.center,
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
            suffixIcon: IconButton(icon: Icon(Icons.search))),
      ),
    );
  }

  Widget _buttonNearMe() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: RaisedButton(
          color: orangeColor2,
          onPressed: () => {},
          child: TextWidget(
            txt: 'NEAR ME',
            txtSize: 10,
            color: Colors.white,
          )),
    ));
  }

  Widget _buttonReset() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: RaisedButton(
          color: Colors.brown,
          onPressed: () => {},
          child: TextWidget(
            txt: 'RESET',
            txtSize: 10,
            color: Colors.white,
          )),
    ));
  }

  Widget _listAction() {
    return Expanded(
      child: Container(
        child: StreamBuilder(
            stream: bloc.getProvier,
            builder: (context, AsyncSnapshot<GetProviderModel> snapshot) {
              if (snapshot.hasData && !isLoading) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      _contentProvider(
                          snapshot.data.data[index].providerName
                              .replaceAll(" ", ""),
                          snapshot.data.data[index].providerId
                              .replaceAll(" ", "")),
                  itemCount: snapshot.data.data.length,
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  Widget _contentProvider(String provider, String id) {
    return Container(
      decoration: new BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 2.0,
          color: Colors.blue.withOpacity(.10),
          offset: Offset(0.0, 5.0),
        ),
      ]),
      margin: EdgeInsets.all(4),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
              child: Column(
                children: <Widget>[
                  TextWidget(
                    txt: provider,
                    align: TextAlign.left,
                    maxLine: 1,
                  ),
                  TextWidget(txt: id, align: TextAlign.left),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.arrow_forward_ios))
          ],
        ),
      ),
    );
  }

  _fetchProvidder() {
    setState(() {
      isLoading = true;
    });
    SharedPreferencesHelper.getDoLogin().then((user) {
      final member = MemberModels.fromJson(json.decode(user));
      ReqGetProvider request = ReqGetProvider(
          cardNumber: member.data.cardNumb,
          birthDate: member.data.birthDate.substring(0, 10),
          planId: changePlan == "" ? widget.planId : changePlan);
      bloc.fetchBenefit(
          request.toMap(),
          (providerModel, status, message) => {
                this.providerModel = providerModel,
                _renderView(status, message)
              });
    });
  }

  _renderView(bool status, String message) {
    if (status) {
      setState(() {
        isLoading = false;
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
