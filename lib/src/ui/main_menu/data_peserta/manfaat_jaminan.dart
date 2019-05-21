import 'package:flutter/material.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class BenefitGuaranty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BenefitGuarantyState();
  }
}

class BenefitGuarantyState extends State<BenefitGuaranty> {
  List<Entry> data = new List<Entry>();
  List<Child> child = new List<Child>();

  @override
  void initState() {
    super.initState();

    for (int i = 1; i < 5; i++) {
      child = new List();

      for (int n = 0; n < i; n++) {
        child.add(Child());
      }
      data.add(Entry(child));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

class Entry {
  Entry([this.children = const <Child>[]]);

  List<Child> children;
}

class Child {
  Child([this.child = const <Child>[]]);

  List<Child> child;
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(''));
    return Card(
      child: ExpansionTile(
        key: PageStorageKey<Entry>(root),
        title: _buildHeader(),
        children: root.children
            .asMap()
            .map((index, element) => MapEntry(
                index,
                Container(
                  margin: EdgeInsets.only(left: 17.0, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Divider(height: 3),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2, top: 8),
                        child: TextWidget(
                          txt: 'Bayar Kamar',
                          txtSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextWidget(
                                txt: 'Max',
                                txtSize: 12,
                              ),
                              TextWidget(
                                txt: 'Available Limit',
                                txtSize: 12,
                              ),
                            ],
                          ),
                          Spacer(flex: 1),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextWidget(
                                txt: '1000.0000 per Daily',
                                txtSize: 12,
                              ),
                              TextWidget(
                                txt: '9000000',
                                txtSize: 12,
                              ),
                            ],
                          ),
                          Spacer(flex: 4),
                        ],
                      ),
                    ],
                  ),
                )))
            .values
            .toList(),
      ),
      elevation: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }

  Widget _buildHeader() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: TextWidget(
              txt: 'RAWAT INAP',
              txtSize: 16,
              color: Colors.blue,
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextWidget(
                    txt: 'Policy Date',
                    txtSize: 14,
                  ),
                  TextWidget(
                    txt: 'Max',
                    txtSize: 14,
                  ),
                  TextWidget(
                    txt: 'Current Limit',
                    txtSize: 14,
                  ),
                ],
              ),
              Spacer(flex: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextWidget(
                    txt: 'Jan/01/2018 - Dec/01/2019',
                    txtSize: 14,
                  ),
                  TextWidget(
                    txt: '100.000.000 yearly',
                    txtSize: 14,
                  ),
                  TextWidget(
                    txt: '900.000',
                    txtSize: 14,
                  ),
                ],
              ),
              Spacer(flex: 5),
            ],
          ),
        ],
      ),
    );
  }
}
