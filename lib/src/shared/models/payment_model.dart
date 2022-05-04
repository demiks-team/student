import 'dart:convert';

import 'enums.dart';
import 'student_model.dart';

List<PaymentModel> paymentFromJson(String str) => List<PaymentModel>.from(
    json.decode(str).map((x) => PaymentModel.fromJson(x)));
String paymentToJson(List<PaymentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModel {
  PaymentModel(
      {required this.id,
      this.studentId,
      this.student,
      this.state,
      this.createdOn,
      this.total,
      this.currencyId,
      this.paymentMethodId,
      this.paymentDate,
      this.paymentMemo});
  int id;
  int? studentId;
  StudentModel? student;
  int? state;
  String? createdOn;
  double? total;
  int? currencyId;
  PaymentMethod? paymentMethodId;
  String? paymentDate;
  String? paymentMemo;
  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        studentId: json["studentId"],
        student: json["student"] != null
            ? StudentModel.fromJson(json["student"])
            : null,
        state: json["state"],
        createdOn: json["createdOn"],
        total: json["total"],
        currencyId: json["currencyId"],
        paymentMethodId: json["paymentMethodId"] != null
            ? PaymentMethod.values[json["paymentMethodId"]]
            : null,
        paymentDate: json["paymentDate"],
        paymentMemo: json["paymentMemo"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "studentId": studentId,
        "student": student != null ? student!.toJson() : null,
        "createdOn": createdOn,
        "total": total,
        "currencyId": currencyId,
        "paymentMethodId": paymentMethodId,
        "paymentDate": paymentDate,
        "paymentMemo": paymentMemo,
      };
}
