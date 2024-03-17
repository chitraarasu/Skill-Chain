import 'package:flutter/cupertino.dart';
import 'package:skill_chain/web/screens/dashboard/pages/skill_approval.dart';
import 'package:skill_chain/web/screens/dashboard/pages/users.dart';
import 'package:skill_chain/web/utils/ui_element.dart';

import '../screens/dashboard/pages/home.dart';
import '../screens/dashboard/pages/institute/institute.dart';
import '../screens/dashboard/pages/verification.dart';

class DashboardModel {
  final String image;
  final String text;
  final String route;
  final Widget screen;

  DashboardModel(this.image, this.text, this.route, this.screen);
}

DashboardModel institute =
    DashboardModel("institution", "Institute", Screens.institute, Institute());

List<DashboardModel> dashboardList = [
  DashboardModel("home", "Dashboard", Screens.dashboard, Home()),
  DashboardModel("test", "Verification", Screens.verification, Verification()),
  DashboardModel("add_skill", "Add Skill", Screens.addSkill,
      Verification(isForAddSkill: true)),
  DashboardModel("skill_approve", "Skill Approval", Screens.skillApproval,
      SkillApproval()),
  DashboardModel("user_management", "Users", Screens.users, Users()),
  // DashboardModel("settings", "Settings", Screens.settings),
  institute,
];
