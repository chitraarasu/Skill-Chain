// To parse this JSON data, do
//
//     final skillsModel = skillsModelFromJson(jsonString);

import 'dart:convert';

import 'package:skill_chain/app/dashboard/screens/verification/app_add_skill.dart';

List<SkillsModel> skillsModelFromJson(List list) =>
    List<SkillsModel>.from(list.map((x) => SkillsModel.fromJson(x)));

String skillsModelToJson(List<SkillsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SkillsModel extends NamedItem {
  // final Timestamp? createdTime;
  final String? accessId;
  final String? category;
  @override
  String name;
  final String? skillId;

  SkillsModel({
    // this.createdTime,
    this.accessId,
    this.category,
    this.name = "",
    this.skillId,
  });

  factory SkillsModel.fromJson(Map<String, dynamic> json) => SkillsModel(
        // createdTime: json["created_time"],
        accessId: json["access_id"].toString(),
        category: json["category"],
        name: json["name"],
        skillId: json["skill_id"],
      );

  Map<String, dynamic> toJson() => {
        // "created_time": createdTime,
        "access_id": accessId,
        "category": category,
        "name": name,
        "skill_id": skillId,
      };
}
