import 'package:skill_chain/web/utils/ui_element.dart';

class DashboardModel {
  final String image;
  final String text;
  final String route;

  DashboardModel(this.image, this.text, this.route);
}

List<DashboardModel> dashboardList = [
  DashboardModel("home", "Dashboard", Screens.dashboard),
  DashboardModel("test", "Verification", Screens.verification),
  DashboardModel("institution", "Institute", Screens.institute),
  DashboardModel("skill_approve", "Skill Approval", Screens.skillApproval),
  DashboardModel("user_management", "Users", Screens.users),
  DashboardModel("settings", "Settings", Screens.settings),
];
