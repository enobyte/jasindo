import 'package:flutter/material.dart';
import 'package:jasindo_app/widgets/ImageCover.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutState();
  }
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false, //disable back button
          backgroundColor: Colors.transparent,
          expandedHeight: MediaQuery.of(context).size.height / 2,
          flexibleSpace: FlexibleSpaceBar(background: _header()),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.all(20),
                child: TextWidget(
                  txt:
                      'Kemudian untuk wilayah Purwakarta diberangkatkan dari Taman Sribaduga sebanyak 1.000 pemudik dengan 25 armada bus. Terakhir wilayah Makassar dengan jumlah 1.000 pemudik dilepas di Rumah Jabatan Gubernur Sulawesi Selatan sebanyak 32 armada bus.Sama seperti tahun-tahun sebelumnya, tujuan Mudik Bersama BPJS TK antara lain Jawa Tengah, Jawa Timur, Yogyakarta, dan Lampung. Sementara untuk titik pelepasan di Kota Makassar akan mengantarkan peserta ke Malili, Mamuju, Toraja, dan Bulukumba.Untuk diketahui, kegiatan Mudik Bersama BPJS TK merupakan wujud terima kasih BPJS TK kepada perusahaan yang tertib administrasi dan tertib iuran dalam pembayaran dan pendaftaran pekerjanya pada program BPJS TK.Pada kesempatan yang sama, anggota Dewan Pengawas BPJS Ketenagakerjaan, Puspita Wulandari mengatakan kegiatan Mudik Bersama BPJS TK merupakan bentuk kepedulian BPJS TK terhadap peserta dan simbiosis mutualisme kepada pekerja dan perusahaan yang patuh membayar iuranSelain menggelar kegiatan mudik gratis, BPJS TK juga telah menyelenggarakan kegiatan Pasar Murah untuk peserta BPJS TK. Pasar Murah menyediakan 69.000 paket sembako murah dari harga Rp 150 ribu dijual seharga Rp 75 ribu yang digelar di 123 kantor cabang BPJS TK. Digelar pula program bagi-bagi takjil gratis kepada masyarakat umum yang dilaksanakan di 202 kantor cabang perintis BPJS TK di seluruh Indonesia.',
                  align: TextAlign.justify,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _header() {
    return ImageCover(true,
        'https://0.s3.envato.com/files/79885804/Crystal-Faces-Background-preview.jpg');
  }
}
