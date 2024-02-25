import 'package:flutter/material.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      child: Row(
        children: [
          CircleAvatar(
            radius: 27.5,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1593085512500-5d55148d6f0d"),
          ),
        ],
      ),
    );
  }
}
