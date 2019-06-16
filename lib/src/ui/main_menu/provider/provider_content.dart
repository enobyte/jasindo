import 'package:flutter/material.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class ProviderContent extends StatefulWidget {
  List<String> listCity;
  GetPlansModel plansModel;
  String cityValue, planId;

  @override
  State<StatefulWidget> createState() {
    return ProviderContentState();
  }

  ProviderContent(
      {this.listCity, this.plansModel, this.cityValue, this.planId});
}

class ProviderContentState extends State<ProviderContent> {
  String changeCity = "", changePlan = "";
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      child: RaisedButton(onPressed: () => {}, child: Text('Sumit')),
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
          onPressed: () => {},
          child: TextWidget(
            txt: 'NEAR ME',
            txtSize: 10,
          )),
    ));
  }

  Widget _buttonReset() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: RaisedButton(
          onPressed: () => {},
          child: TextWidget(
            txt: 'RESET',
            txtSize: 10,
          )),
    ));
  }

  Widget _listAction() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => _contentProvider(),
          itemCount: 10,
        ),
      ),
    );
  }

  Widget _contentProvider() {
    return Container(
      margin: EdgeInsets.all(4),
      child: Card(
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
              child: Column(
                children: <Widget>[
                  TextWidget(txt: 'THC'),
                  TextWidget(txt: '0712'),
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
}
