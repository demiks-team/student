import 'dart:convert';

import 'invoice_model.dart';
import 'student_model.dart';

List<ScheduledPaymentModel> scheduledPaymentFromJson(String str) =>
    List<ScheduledPaymentModel>.from(
        json.decode(str).map((x) => ScheduledPaymentModel.fromJson(x)));
String scheduledPaymentToJson(List<ScheduledPaymentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduledPaymentModel {
  ScheduledPaymentModel({
    required this.id,
    this.studentId,
    this.student,
    this.invoiceId,
    this.invoice,
    this.paymentAmount,
    this.scheduledDate,
    this.createdOn,
    this.discountRate,
  });
  int id;
  int? studentId;
  StudentModel? student;
  int? invoiceId;
  InvoiceModel? invoice;
  double? paymentAmount;
  String? scheduledDate;
  String? createdOn;
  double? discountRate;
  factory ScheduledPaymentModel.fromJson(Map<String, dynamic> json) =>
      ScheduledPaymentModel(
        id: json["id"],
        studentId: json["studentId"],
        student: json["student"] != null
            ? StudentModel.fromJson(json["student"])
            : null,
        invoiceId: json["invoiceId"],
        invoice: json["invoice"] != null
            ? InvoiceModel.fromJson(json["invoice"])
            : null,
        paymentAmount: json["paymentAmount"],
        scheduledDate: json["scheduledDate"],
        createdOn: json["createdOn"],
        discountRate: json["discountRate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentId": studentId,
        "student": student != null ? student!.toJson() : null,
        "invoiceId": invoiceId,
        "invoice": invoice != null ? invoice!.toJson() : null,
        "paymentAmount": paymentAmount,
        "scheduledDate": scheduledDate,
        "createdOn": createdOn,
        "discountRate": discountRate,
      };
}
