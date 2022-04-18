import 'dart:convert';

List<UserModel> userFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));
String userToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel(
      {required this.id,
      this.fullName,
      this.image,
      this.token,
      this.refresh,
      this.languageId});

  int id;
  String? fullName;
  String? image;
  int? languageId;
  String? token;
  String? refresh;
  // SchoolModel? school;
  // int? schoolId;
  // int? subscriptionPlan;
  // String? imageName;
  // bool? hasPassword;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["fullName"],
        image: json["image"],
        token: json["token"],
        refresh: json["refresh"],
        languageId: json["languageId"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "image": image,
        "token": token,
        "refresh": refresh,
        "languageId": languageId,
      };
}
