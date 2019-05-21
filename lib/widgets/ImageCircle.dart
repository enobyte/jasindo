import 'package:flutter/material.dart';

class ImageCircle extends StatelessWidget {
  final bool isNetwork;
  final String pathImage;
  final double size;

  ImageCircle(this.isNetwork, this.pathImage, this.size);

  @override
  Widget build(BuildContext context) {
    return isNetwork
        ? Material(
            elevation: 4.0,
            shape: CircleBorder(),
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(size),
              child: Image.network(
                pathImage,
                fit: BoxFit.cover,
                height: size,
                width: size,
              ),
            ),
          )
        : Material(
            elevation: 4.0,
            shape: CircleBorder(),
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(size),
              child: Image.asset(pathImage,
                  fit: BoxFit.cover, height: size, width: size),
            ),
          );
  }
}
