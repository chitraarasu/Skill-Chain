// To parse this JSON data, do
//
//     final skillsModel = skillsModelFromJson(jsonString);

import 'dart:convert';

List<SkillsModel> skillsModelFromJson(List list) =>
    List<SkillsModel>.from(list.map((x) => SkillsModel.fromJson(x)));

String skillsModelToJson(List<SkillsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SkillsModel {
  // final Timestamp? createdTime;
  final String? accessId;
  final String? category;
  final String? name;

  SkillsModel({
    // this.createdTime,
    this.accessId,
    this.category,
    this.name,
  });

  factory SkillsModel.fromJson(Map<String, dynamic> json) => SkillsModel(
        // createdTime: json["created_time"],
        accessId: json["access_id"].toString(),
        category: json["category"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        // "created_time": createdTime,
        "access_id": accessId,
        "category": category,
        "name": name,
      };
}
