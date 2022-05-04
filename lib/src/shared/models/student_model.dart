import 'dart:convert';

List<StudentModel> studentFromJson(String str) => List<StudentModel>.from(
    json.decode(str).map((x) => StudentModel.fromJson(x)));
String studentToJson(List<StudentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentModel {
  StudentModel({
    required this.id,
    this.fullName,
    this.phoneNumber,
    this.email,
  });
  int id;
  String? fullName;
  String? phoneNumber;
  String? email;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json["id"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
      };
}
