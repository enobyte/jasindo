import 'package:flutter/material.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class SideMenu extends StatelessWidget {
  Function onClick;
  String name;

  final List<MenuItem> options = [
    MenuItem(Icons.home, 'Home'),
    MenuItem(Icons.library_books, 'Buku Panduan'),
    MenuItem(Icons.highlight, 'Berita'),
    MenuItem(Icons.info, 'Informasi'),
    MenuItem(Icons.error, 'Tentang Kami'),
    MenuItem(Icons.settings, 'Pengaturan'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 100,
          left: 30,
          bottom: 8,
          right: MediaQuery.of(context).size.width / 2.9),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextWidget(
                  txt: 'Selamat Datang',
                  color: blueStandart,
                  txtSize: 12,
                ),
                SizedBox(height: 4),
                TextWidget(
                  txt: name,
                  align: TextAlign.left,
                  fontFamily: 'SF-Bold',
                  color: blueStandart,
                  txtSize: 20,
                )
              ],
            ),
          ),
          Column(
            children: options
                .asMap()
                .map((index, item) => MapEntry(
                    index,
                    ListTile(
                      onTap: () {
                        _onClickList(index);
                      },
                      leading: Icon(
                        item.icon,
                        color: Colors.black,
                        size: 20,
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )))
                .values
                .toList(),
          ),
        ],
      ),
    );
  }

  Future _onClickList(int index) async {
    await this.onClick(index);
  }

  SideMenu({this.onClick, this.name});
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
