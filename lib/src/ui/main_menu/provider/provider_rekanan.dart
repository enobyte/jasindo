import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/getplans_bloc.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/requests/do_req_plans.dart';
import 'package:jasindo_app/src/ui/main_menu/provider/provider_content.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ImageCover.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class ProviderRekanan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProviderRekananState();
  }
}

class ProviderRekananState extends State<ProviderRekanan> {
  String _planId, _cardNumber, _birthDate, cityValue, _planType;
  GetPlansModel plansModel = GetPlansModel();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final planbloc = GetPlansBloc();

  List<String> _listCity = [
    'AMBON',
    'BALIK PAPAN',
    'BANDA ACEH',
    'BANDAR LAMPUNG',
    'BANDUNG',
    'BANJAR',
    'BANJARBARU',
    'BANJARMASIN',
    'BATAM',
    'BATU',
    'BAU-BAU',
    'BEKASI',
    'BENGKULU',
    'BIMA',
    'BINJAI',
    'BITUNG',
    'BLITAR',
    'BOGOR',
    'BONTANG',
    'BUKITTINGGI',
    'CILEGON',
    'CIMAHI',
    'CIREBON',
    'DENPASAR',
    'DEPOK',
    'DUMAI',
    'GORONTALO',
    'GUNUNGSITOLI',
    'JAKARTA',
    'JAKARTA BARAT',
    'JAKARTA PUSAT',
    'JAKARTA SELATAN',
    'JAKARTA TIMUR',
    'JAKARTA UTARA',
    'JAMBI',
    'JAYAPURA',
    'KEDIRI',
    'KENDARI',
    'KOTAMOBAGU',
    'KUPANG',
    'LANGSA',
    'LHOKSEUMAWE',
    'LUBUKLINGGAU',
    'MADIUN',
    'MAGELANG',
    'MAKASSAR',
    'MALANG',
    'MANADO',
    'MATARAM',
    'MEDAN',
    'METRO',
    'MOJOKERTO',
    'PADANG',
    'PADANGPANJANG',
    'PADANGSEDEMPUAN',
    'PAGAR ALAM',
    'PALANGKARAYA',
    'PALEMBANG',
    'PALOPO',
    'PALU',
    'PANGKAL PINANG',
    'PAREPARE',
    'PARIAMAN',
    'PASURUAN',
    'PAYAKUMBUH',
    'PEKALONGAN',
    'PEKANBARU',
    'PEMATANGSIANTAR',
    'PONTIANAK',
    'PRABUMULIH',
    'PROBOLINGGO',
    'SABANG',
    'SALATIGA',
    'SAMARINDA',
    'SAWAHLUNTO',
    'SEMARANG',
    'SERANG',
    'SIBOLGA',
    'SINGKAWANG',
    'SOLOK',
    'SORONG',
    'SUBULUSSALAM',
    'SUKABUMI',
    'SUNGAI PENUH',
    'SURABAYA',
    'SURAKARTA',
    'TANGERANG SELATAN',
    'TANGERANG',
    'TANJUNGBALAI',
    'TANJUNG PINANG',
    'TARAKAN',
    'TASIKMALAYA',
    'TEBING TINGGI',
    'TEGAL',
    'TERNATE',
    'TIDORE',
    'KEPULAUAN',
    'TOMOHON',
    'TUAL',
    'YOGYAKARTA'
  ];

  @override
  void initState() {
    super.initState();
    _fetchPlan();
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
      body: Column(
        children: <Widget>[_bannerTop(), _viewBottom()],
      ),
    );
  }

  Widget _bannerTop() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: ImageCover(false, 'lib/assets/images/background_provider.png'),
    );
  }

  Widget _viewBottom() {
    return Column(
      children: <Widget>[
        _searchCity(),
        _searchChooseJaminan(),
        SizedBox(
          height: 10,
        ),
        _btnSubmit(),
        SizedBox(
          height: 10,
        ),
        _btnNearme()
      ],
    );
  }

  Widget _searchCity() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 30, 30, 5),
      height: 40,
      alignment: FractionalOffset.center,
      padding: EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: TextWidget(
            txt: 'SEMUA KOTA',
            txtSize: 10,
          ),
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              cityValue = newValue;
            });
          },
          value: cityValue,
          items: _listCity.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }

  Widget _searchChooseJaminan() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 5, 30, 10),
      height: 40,
      alignment: FractionalOffset.center,
      padding: EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: TextWidget(
            txt: 'PILIH JAMINAN',
            txtSize: 10,
          ),
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              _planId = newValue;
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
    );
  }

  Widget _btnSubmit() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onPressed: () => {
            _planId != null
                ? routeToWidget(
                    context,
                    ProviderContent(
                      listCity: _listCity,
                      plansModel: plansModel,
                      cityValue: cityValue,
                      planId: _planId,
                    ))
                : _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Jaminan harus dipilih')))
          },
      textColor: Colors.white,
      color: Color.fromRGBO(0, 96, 153, 1.0),
      splashColor: Colors.blueGrey,
      padding: EdgeInsets.only(left: 50, right: 50),
      child: new TextWidget(
        txt: "SUBMIT",
      ),
    );
  }

  Widget _btnNearme() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onPressed: () => {
            _planId != null
                ? routeToWidget(
                    context,
                    ProviderContent(
                      listCity: _listCity,
                      plansModel: plansModel,
                      cityValue: cityValue,
                      planId: _planId,
                    ))
                : _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Jaminan harus dipilih')))
          },
      textColor: Colors.white,
      color: orangeColor1,
      splashColor: Colors.blueGrey,
      padding: EdgeInsets.only(left: 46, right: 46),
      child: new TextWidget(
        txt: "NEAR ME",
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
}
