import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_web_image/universal_web_image.dart';

import '../color_manager.dart';

class CustomProfile extends StatelessWidget {
  final double? radius;
  final double? width;
  final String? image;

  CustomProfile({this.radius, this.width, this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 55,
      child: Row(
        children: [
          SizedBox(
            width: 55,
            height: 55,
            child: Center(
              child: ClipOval(
                child: NetImage(image ??
                    "https://images.unsplash.com/photo-1593085512500-5d55148d6f0d"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NetImage extends StatelessWidget {
  final String image;

  NetImage(this.image);

  @override
  Widget build(BuildContext context) {
    return UniversalWebImage(
      imageUrl: image,
      customLoaderBuilder: (_) {
        return Container(
          color: colorGrey3,
        );
      },
    );
  }
}
