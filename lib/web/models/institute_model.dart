// To parse this JSON data, do
//
//     final instituteModel = instituteModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

InstituteModel instituteModelFromJson(String str) =>
    InstituteModel.fromJson(json.decode(str));

String instituteModelToJson(InstituteModel data) => json.encode(data.toJson());

class InstituteModel {
  final String? instituteAccess;
  final String? instituteId;
  final String? uid;
  final String? instituteAddress;
  final Timestamp? createdAt;
  final String? instituteName;
  final String? instituteEmail;
  final String? logo;
  final String? password;

  InstituteModel({
    this.instituteAccess,
    this.instituteId,
    this.uid,
    this.instituteAddress,
    this.createdAt,
    this.instituteName,
    this.instituteEmail,
    this.logo,
    this.password,
  });

  factory InstituteModel.fromJson(Map<String, dynamic> json) => InstituteModel(
        instituteAccess: json["institute_access"],
        instituteId: json["institute_id"],
        uid: json["uid"],
        instituteAddress: json["institute_address"],
        createdAt: json["created_at"],
        instituteName: json["institute_name"],
        instituteEmail: json["institute_email"],
        logo: json["logo"].toString().isEmpty ? null : json["logo"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "institute_access": instituteAccess,
        "institute_id": instituteId,
        "uid": uid,
        "institute_address": instituteAddress,
        "created_at": createdAt,
        "institute_name": instituteName,
        "institute_email": instituteEmail,
        "logo": logo,
        "password": password,
      };
}
