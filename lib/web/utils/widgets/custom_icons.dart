import 'package:flutter/material.dart';

import '../color_manager.dart';

class CustomIcons extends StatelessWidget {
  const CustomIcons({super.key});

  Widget getIcon(IconData icon, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Icon(
        icon,
        color: color ?? colorGrey1,
        size: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getIcon(Icons.remove_red_eye_rounded),
          getIcon(Icons.edit),
          getIcon(Icons.delete, color: orange),
        ],
      ),
    );
  }
}
