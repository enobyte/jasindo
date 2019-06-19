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
import 'package:location/location.dart';


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
  var location = new Location();
  double latitude = 0.0, longitude = 0.0;

  @override
  void initState() {
    super.initState();
    _getLocationData(changeCity == "" ? widget.cityValue : changeCity,
        changePlan == "" ? widget.planId : changePlan);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    _searchController.dispose();
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
      height: 30,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          color: orangeColor2,
          onPressed: () => {
                _getLocationData(
                    changeCity == "" ? widget.cityValue : changeCity,
                    changePlan == "" ? widget.planId : changePlan)
              },
          child: TextWidget(
            txt: 'SUBMIT',
            txtSize: 9,
            color: Colors.white,
          )),
    ));
  }

  Widget _searchAny() {
    return Container(
      height: 40,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
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
      height: 30,
      margin: EdgeInsets.only(left: 8, right: 8),
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: orangeColor2,
          onPressed: () => {_setNearby()},
          child: TextWidget(
            txt: 'NEAR ME',
            txtSize: 9,
            color: Colors.white,
          )),
    ));
  }

  Widget _buttonReset() {
    return Expanded(
        child: Container(
      height: 30,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          color: Colors.brown,
          onPressed: () => {},
          child: TextWidget(
            txt: 'RESET',
            txtSize: 9,
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
                snapshot.data.data
                    ..sort((a, b) => a.providerId.compareTo(b.providerId));
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      _contentProvider(snapshot, index),
                  itemCount: snapshot.data.data == null
                      ? 0
                      : snapshot.data.data.length,
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  Widget _contentProvider(AsyncSnapshot<GetProviderModel> snapshot, int index) {
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
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      txt: snapshot.data.data[index].providerName.trim(),
                      color: blueStandart,
                      fontFamily: 'SF-Semibold',
                      align: TextAlign.left,
                      maxLine: 2,
                    ),
                    TextWidget(
                        txt: snapshot.data.data[index].providerId.trim(),
                        align: TextAlign.left),
                  ],
                ),
              ),
            ),
            Container(
              child: TextWidget(
                txt: snapshot.data.data[index].distance.trim(),
                align: TextAlign.right,
                txtSize: 10,
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

  _fetchProvidder(String city, String planId) {
    setState(() {
      isLoading = true;
    });
    SharedPreferencesHelper.getDoLogin().then((user) {
      final member = MemberModels.fromJson(json.decode(user));
      ReqGetProvider request = ReqGetProvider(
          cardNumber: member.data.cardNumb,
          birthDate: member.data.birthDate.substring(0, 10),
          planId: planId,
          city: city,
          latitude: latitude,
          longitude: longitude);
      bloc.fetchProvider(
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

  _getLocationData(String city, String planId) async {
    await location.getLocation().then((LocationData currentLocation) {
      latitude = currentLocation.latitude;
      longitude = currentLocation.longitude;
      _fetchProvidder(city, planId);
    });
//
//    location.onLocationChanged().listen((LocationData currentLocation) {
//      latitude = currentLocation.latitude;
//      longitude = currentLocation.longitude;
//    });
  }

  _setNearby() {
    _getLocationData("", changePlan == "" ? widget.planId : changePlan);
  }
}
