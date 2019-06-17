import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageSvg extends StatelessWidget {
  final bool isNetwork;
  final String pathImage;
  final Color color;

  ImageSvg({this.isNetwork, this.pathImage, this.color});

  @override
  Widget build(BuildContext context) {
    return isNetwork
        ? SvgPicture.network(
            pathImage,
            color: color,
          )
        : SvgPicture.asset(
            pathImage,
            color: color,
          );
  }
}
