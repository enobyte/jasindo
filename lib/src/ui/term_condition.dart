import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class TermCondition extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TermConditionState();
  }
}

class TermConditionState extends State<TermCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title:
              Text("Syarat & Ketentuan", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Column(
            children: <Widget>[_title(), _content()],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return TextWidget(
      txt: titleTermCondition,
      color: blueStandart,
      txtSize: 25,
      align: TextAlign.left,
      fontFamily: 'SF-Bold',
    );
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextWidget(
        align: TextAlign.justify,
        txt:
            'Selamat datang di www.tokopedia.com.Syarat & ketentuan yang ditetapkan di bawah ini mengatur pemakaian jasa yang ditawarkan oleh PT. Tokopedia terkait penggunaan situs www.tokopedia.com. Pengguna disarankan membaca dengan seksama karena dapat berdampak kepada hak dan kewajiban Pengguna di bawah hukum.Dengan mendaftar dan/atau menggunakan situs www.tokopedia.com, maka pengguna dianggap telah membaca, mengerti, memahami dan menyutujui semua isi dalam Syarat & ketentuan. Syarat & ketentuan ini merupakan bentuk kesepakatan yang dituangkan dalam sebuah perjanjian yang sah antara Pengguna dengan PT.Tokopedia. Jika pengguna tidak menyetujui salah satu, sebagian, atau seluruh isi Syarat & ketentuan, maka pengguna tidak diperkenankan menggunakan layanan di www.tokopedia.com.',
      ),
    );
  }
}
