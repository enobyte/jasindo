import 'package:flutter/material.dart';
import 'package:jasindo_app/src/ui/main_menu/data_peserta/detail_info.dart';
import 'package:jasindo_app/src/ui/main_menu/data_peserta/manfaat_jaminan.dart';
import 'package:jasindo_app/widgets/BubbleTabIndicator.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: TextWidget(txt: "Data Peserta", color: Colors.black),
        backgroundColor: Colors.white,
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
        return DetailInfoPeserta();
        break;
      case 1:
        return BenefitGuaranty();
        break;
      case 2:
        return Container();
        break;
    }
  }
}
