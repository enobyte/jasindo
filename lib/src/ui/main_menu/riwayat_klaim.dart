import 'package:flutter/material.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class RiwayatKlaim extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RiwayatKlaimState();
  }
}

class RiwayatKlaimState extends State<RiwayatKlaim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                //monthValue = newValue;
              });
            },
            items: <String>[
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              'Dec'
            ].map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _klaimList() {
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
            hint: Text('TIPE KLAIM'),
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                //monthValue = newValue;
              });
            },
            items: <String>[
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              'Dec'
            ].map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
          ),
        ),
      ),
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
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            _listHistoryClaimContent(),
        itemCount: 10,
      ),
    );
  }

  Widget _listHistoryClaimContent() {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 4,
      shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      child: Column(
        children: <Widget>[
          _claimContentTop(),
          _claimContentMiddle(),
          __claimContentBottom()
        ],
      ),
    );
  }

  Widget _claimContentTop() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(
                txt: 'CLAIM ID',
                txtSize: 10,
                color: Colors.blue,
              ),
              SizedBox(height: 10),
              TextWidget(txt: 'PROVIDER', txtSize: 10, color: Colors.blue),
              TextWidget(txt: 'ADMISSION', txtSize: 10, color: Colors.blue),
              TextWidget(txt: 'DISCHARGE', txtSize: 10, color: Colors.blue),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(txt: '123456', txtSize: 10),
              SizedBox(height: 10),
              TextWidget(txt: 'RS Budi Kemuliaan', txtSize: 10),
              TextWidget(txt: 'Apr/01/2016', txtSize: 10),
              TextWidget(txt: 'Apr/01/2016', txtSize: 10),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(txt: 'STATUS', txtSize: 10, color: Colors.blue),
              SizedBox(height: 10),
              TextWidget(txt: 'CLAIM TYPE', txtSize: 10, color: Colors.blue),
              TextWidget(txt: 'BENEFIT', txtSize: 10, color: Colors.blue),
              TextWidget(txt: 'DIAGNOSIS', txtSize: 10, color: Colors.blue),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(txt: 'VALID CLAIM', txtSize: 10),
              SizedBox(height: 10),
              TextWidget(txt: 'CASHLESS', txtSize: 10),
              TextWidget(txt: 'Rawat Jalan', txtSize: 10),
              TextWidget(txt: 'Typhoid Fever', txtSize: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _claimContentMiddle() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(txt: 'INCURED', txtSize: 10, color: Colors.blue),
              TextWidget(txt: 'Rp.1000.000', txtSize: 10),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(txt: 'APPROVED', txtSize: 10, color: Colors.blue),
              TextWidget(txt: 'RS Budi Kemuliaan', txtSize: 10),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(txt: 'EXCESS', txtSize: 10, color: Colors.blue),
              TextWidget(txt: 'RS Budi Kemuliaan', txtSize: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget __claimContentBottom() {
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
              txt:
                  'PEMBAYARAN DI TRANSFER KE BANK BCA CAB CILEDUG NO REK :12345678 A/D PT BUDI KEMULIAAN ',
              align: TextAlign.left,
              txtSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
