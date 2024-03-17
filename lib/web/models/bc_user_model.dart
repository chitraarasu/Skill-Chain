// To parse this JSON data, do
//
//     final bcUserModel = bcUserModelFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';

BcUserModel bcUserModelFromJson(String str) =>
    BcUserModel.fromJson(json.decode(str));

String bcUserModelToJson(BcUserModel data) => json.encode(data.toJson());

class BcUserModel {
  final bool? status;
  final String? message;
  final List<BcUser>? data;

  BcUserModel({
    this.status,
    this.message,
    this.data,
  });

  factory BcUserModel.fromJson(Map<String, dynamic> json) => BcUserModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BcUser>.from(json["data"]!.map((x) => BcUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BcUser {
  final String? address;

  // final Timestamp? createdAt;
  final String? emailId;
  final String? imageUrl;
  final String? mobileNo;
  final String? name;
  final String? publicId;
  final List<Skill>? skills;
  final bool? status;
  Rxn<Uint8List> selectedDoc = Rxn();
  Rxn<String> selectedDocUrl = Rxn();

  setDocFile(Uint8List file) {
    selectedDoc.value = file;
  }

  setDocFileUrl(String url) {
    selectedDocUrl.value = url;
  }

  BcUser({
    this.address,
    // this.createdAt,
    this.emailId,
    this.imageUrl,
    this.mobileNo,
    this.name,
    this.publicId,
    this.skills,
    this.status,
  });

  factory BcUser.fromJson(Map<String, dynamic> json) => BcUser(
        address: json["address"],
        // createdAt: Timestamp.fromMillisecondsSinceEpoch(json["created_at"]),
        emailId: json["email_id"],
        imageUrl: json["imageUrl"],
        mobileNo: json["mobile_no"],
        name: json["name"],
        publicId: json["public_id"].toString(),
        skills: json["skills"] == null
            ? []
            : List<Skill>.from(json["skills"]!.map((x) => Skill.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        // "created_at": createdAt,
        "email_id": emailId,
        "imageUrl": imageUrl,
        "mobile_no": mobileNo,
        "name": name,
        "public_id": publicId,

        "skills": skills == null
            ? []
            : List<dynamic>.from(skills!.map((x) => x.toJson())),
        "status": status,
      };
}

class Skill {
  final String? instituteId;
  final String? skillDoc;
  final String? skillId;

  Skill({
    this.instituteId,
    this.skillDoc,
    this.skillId,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        instituteId: json["institute_id"],
        skillDoc: json["skill_doc"],
        skillId: json["skill_id"],
      );

  Map<String, dynamic> toJson() => {
        "institute_id": instituteId,
        "skill_doc": skillDoc,
        "skill_id": skillId,
      };
}
