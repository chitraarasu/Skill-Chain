import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/ui_element.dart';
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
            width: width ?? 55,
            height: width ?? 55,
            child: ClipOval(
              child: !image.toString().contains("http")
                  ? Container(
                      color: brown1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image(
                          image: AssetImage(assetImage("profile_dummy")),
                        ),
                      ),
                    )
                  : NetImage(image ?? ""),
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
      fit: BoxFit.cover,
      customLoaderBuilder: (_) {
        return Container(
          color: colorGrey3,
        );
      },
    );
  }
}
