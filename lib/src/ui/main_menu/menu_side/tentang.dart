import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/about_bloc.dart';
import 'package:jasindo_app/src/models/abouts_model.dart';
import 'package:jasindo_app/widgets/ImageCover.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';
import 'package:flutter_html/flutter_html.dart';

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutState();
  }
}

class AboutState extends State<About> {
  AboutsModels models;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        automaticallyImplyLeading: false, //disable back button
        backgroundColor: Colors.transparent,
        expandedHeight: MediaQuery.of(context).size.height / 2,
        flexibleSpace: FlexibleSpaceBar(background: _header()),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            models == null
                ? Center(child: CircularProgressIndicator())
                : Container(
                    padding: EdgeInsets.all(20),
                    child: Html(
                      data: _getAbout(),
                    ))
          ],
        ),
      )
    ]);
  }

  Widget _header() {
    return InkWell(
      onTap: () => {},
      child: models == null
          ? Center(child: CircularProgressIndicator())
          : Image.network(_getImage()),
    );
  }

  _fetchData() {
    bloc.aboutBloc((status, message, models) => {_renderView(models)});
  }

  _renderView(AboutsModels aboutModel) async {
    setState(() {
      this.models = aboutModel;
    });
  }

  String _getAbout() {
    String description = "";
    models.data.forEach((data) {
      if (data.name == "aboutme") {
        description = data.descriptions;
      }
    });
    return description;
  }

  String _getImage() {
    String image = "";
    models.data.forEach((data) {
      if (data.name == "aboutme") {
        image = data.image;
      }
    });
    return image;
  }
}
