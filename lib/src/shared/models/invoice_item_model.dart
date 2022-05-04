import 'dart:convert';

import 'course_model.dart';

List<InvoiceItemModel> invoiceItemFromJson(String str) =>
    List<InvoiceItemModel>.from(
        json.decode(str).map((x) => InvoiceItemModel.fromJson(x)));
String invoiceItemToJson(List<InvoiceItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceItemModel {
  InvoiceItemModel({
    required this.id,
    this.invoiceId,
    this.quantity,
    this.unitPrice,
    this.discountAmount,
    this.subtotalPrice,
    this.courseId,
    this.course,
  });
  int id;
  int? invoiceId;
  int? quantity;
  double? unitPrice;
  double? discountAmount;
  double? subtotalPrice;
  int? courseId;
  CourseModel? course;
  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) =>
      InvoiceItemModel(
        id: json["id"],
        invoiceId: json["invoiceId"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
        discountAmount: json["discountAmount"],
        subtotalPrice: json["subtotalPrice"],
        courseId: json["programId"],
        course: json["program"] != null
            ? CourseModel.fromJson(json["program"])
            : null,
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "invoiceId": invoiceId,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "discountAmount": discountAmount,
        "subtotalPrice": subtotalPrice,
        "programId": courseId,
        "program": course,
      };
}
