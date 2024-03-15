// To parse this JSON data, do
//
//     final customUserModel = customUserModelFromJson(jsonString);

import 'dart:convert';

CustomUserModel customUserModelFromJson(String str) =>
    CustomUserModel.fromJson(json.decode(str));

String customUserModelToJson(CustomUserModel data) =>
    json.encode(data.toJson());

class CustomUserModel {
  final String? logo;
  final String? instituteAccess;
  final String? instituteEmail;
  final String? instituteAddress;
  final String? instituteId;
  final String? instituteName;
  final String? uid;

  CustomUserModel({
    this.logo,
    this.instituteAccess,
    this.instituteEmail,
    this.instituteAddress,
    this.instituteId,
    this.instituteName,
    this.uid,
  });

  factory CustomUserModel.fromJson(Map<String, dynamic> json) =>
      CustomUserModel(
        logo: json["logo"],
        instituteAccess: json["institute_access"],
        instituteEmail: json["institute_email"],
        instituteAddress: json["institute_address"],
        instituteId: json["institute_id"],
        instituteName: json["institute_name"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
        "institute_access": instituteAccess,
        "institute_email": instituteEmail,
        "institute_address": instituteAddress,
        "institute_id": instituteId,
        "institute_name": instituteName,
        "uid": uid,
      };
}
