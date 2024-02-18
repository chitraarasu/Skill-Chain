class DashboardModel {
  final String image;
  final String text;

  DashboardModel(this.image, this.text);
}

List<DashboardModel> dashboardList = [
  DashboardModel("home", "Dashboard"),
  DashboardModel("test", "Verification"),
  DashboardModel("institution", "Institute"),
  DashboardModel("skill_approve", "Skill Approval"),
  DashboardModel("user_management", "Users"),
  DashboardModel("settings", "Settings"),
];
