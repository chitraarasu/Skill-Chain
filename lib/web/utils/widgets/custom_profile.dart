import 'package:flutter/material.dart';

class CustomProfile extends StatelessWidget {
  final double? radius;
  final double? width;

  CustomProfile({this.radius, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 55,
      child: Row(
        children: [
          CircleAvatar(
            radius: radius ?? 27.5,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1593085512500-5d55148d6f0d"),
          ),
        ],
      ),
    );
  }
}
