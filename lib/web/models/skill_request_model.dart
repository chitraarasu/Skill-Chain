// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

List<RequestModel> requestModelFromJson(String str) => List<RequestModel>.from(
    json.decode(str).map((x) => RequestModel.fromJson(x)));

String requestModelToJson(List<RequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestModel {
  final String? status;
  final String? industryId;
  final String? userId;
  final String? certificateUrl;
  final String? skillId;

  RequestModel({
    this.status,
    this.industryId,
    this.userId,
    this.certificateUrl,
    this.skillId,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        status: json["status"],
        industryId: json["industry_id"],
        userId: json["user_id"],
        certificateUrl: json["certificate_url"],
        skillId: json["skill_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "industry_id": industryId,
        "user_id": userId,
        "certificate_url": certificateUrl,
        "skill_id": skillId,
      };
}
