import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {

  final List<MenuItem> options = [
    MenuItem(Icons.search, 'Buku Panduan'),
    MenuItem(Icons.shopping_basket, 'Berita'),
    MenuItem(Icons.favorite, 'Informasi'),
    MenuItem(Icons.code, 'Tentang Kami'),
    MenuItem(Icons.format_list_bulleted, 'Pengaturan'),
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
                Text(
                  'Selamat Datang',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Tatiana',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
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
                        debugPrint(index.toString());
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
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
