import 'package:flutter/material.dart';
import 'package:jasindo_app/widgets/TransparentImage.dart';

class ImageCover extends StatelessWidget {
  final bool isNetwork;
  final String pathImage;

  ImageCover(this.isNetwork, this.pathImage);

  @override
  Widget build(BuildContext context) {
    return isNetwork
        ? Stack(
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
              FadeInImage.memoryNetwork(
                  placeholder: transparentImage,
                  image: pathImage,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center)
            ],
          )
        : Image.asset(pathImage,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center);
  }
}
