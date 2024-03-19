// To parse this JSON data, do
//
//     final customUserModel = customUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:skill_chain/app/dashboard/screens/verification/app_add_skill.dart';

InstituteUserModel customUserModelFromJson(String str) =>
    InstituteUserModel.fromJson(json.decode(str));

String customUserModelToJson(InstituteUserModel data) =>
    json.encode(data.toJson());

class InstituteUserModel extends NamedItem {
  final String? logo;
  final String? instituteAccess;
  final String? instituteEmail;
  final String? instituteAddress;
  final String? instituteId;
  final String? instituteName;
  final String? uid;
  final String? password;

  InstituteUserModel({
    this.logo,
    this.instituteAccess,
    this.instituteEmail,
    this.instituteAddress,
    this.instituteId,
    this.instituteName,
    this.uid,
    this.password,
  });

  factory InstituteUserModel.fromJson(Map<String, dynamic> json) =>
      InstituteUserModel(
        logo: json["logo"],
        instituteAccess: json["institute_access"],
        instituteEmail: json["institute_email"],
        instituteAddress: json["institute_address"],
        instituteId: json["institute_id"],
        instituteName: json["institute_name"],
        uid: json["uid"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
        "institute_access": instituteAccess,
        "institute_email": instituteEmail,
        "institute_address": instituteAddress,
        "institute_id": instituteId,
        "institute_name": instituteName,
        "uid": uid,
        "password": password,
      };

  @override
  String get name => instituteName ?? "";
}
