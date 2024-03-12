import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: getCustomFont("Dashboard", 15)),
    );
  }
}
