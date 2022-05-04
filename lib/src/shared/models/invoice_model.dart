import 'dart:convert';

import 'invoice_item_model.dart';
import 'student_model.dart';

List<InvoiceModel> invoiceFromJson(String str) => List<InvoiceModel>.from(
    json.decode(str).map((x) => InvoiceModel.fromJson(x)));
String invoiceToJson(List<InvoiceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceModel {
  InvoiceModel({
    required this.id,
    this.invoiceCode,
    this.createdOn,
    this.schoolId,
    this.schoolName,
    this.subtotal,
    this.studentId,
    this.student,
    this.currencyId,
    this.invoiceItems,
    this.discountAmount,
    this.tax,
    this.registrationFee,
    this.total,
    this.isInvoiceRefunded,
  });
  int id;
  String? invoiceCode;
  String? createdOn;
  int? schoolId;
  String? schoolName;
  double? subtotal;
  int? studentId;
  StudentModel? student;
  int? currencyId;
  List<InvoiceItemModel>? invoiceItems;
  double? discountAmount;
  double? tax;
  double? registrationFee;
  double? total;
  bool? isInvoiceRefunded;
  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        id: json["id"],
        invoiceCode: json["invoiceCode"],
        createdOn: json["createdOn"],
        schoolId: json["schoolId"],
        schoolName: json["schoolName"],
        subtotal: json["subtotal"],
        studentId: json["studentId"],
        student: json["student"] != null
            ? StudentModel.fromJson(json["student"])
            : null,
        currencyId: json["currencyId"],
        invoiceItems: json["invoiceItems"] != null
            ? (json["invoiceItems"] as List)
                .map(
                  (dynamic item) => InvoiceItemModel.fromJson(item),
                )
                .toList()
            : null,
        discountAmount: json["discountAmount"],
        tax: json["tax"],
        registrationFee: json["registrationFee"],
        total: json["total"],
        isInvoiceRefunded: json["isInvoiceRefunded"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoiceCode": invoiceCode,
        "createdOn": createdOn,
        "schoolId": schoolId,
        "schoolName": schoolName,
        "subtotal": subtotal,
        "studentId": studentId,
        "student": student != null ? student!.toJson() : null,
        "currencyId": currencyId,
        if (invoiceItems != null)
          "invoiceItems": invoiceItems
        else
          "invoiceItems": null,
        "discountAmount": discountAmount,
        "tax": tax,
        "registrationFee": registrationFee,
        "total": total,
        "isInvoiceRefunded": isInvoiceRefunded,
      };
}
