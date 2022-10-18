import 'dart:convert';


List<RefundModel> refundFromJson(String str) =>
    List<RefundModel>.from(json.decode(str).map((x) => RefundModel.fromJson(x)));
String refundToJson(List<RefundModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class RefundModel {
  RefundModel({
    required this.id,
    this.schoolId,
    this.invoiceId,
    this.createdOn,
    this.refundDate,
    this.refundMethodId,
    this.reasonId,
    this.refundMemo,
    this.amount,
  });
  int id;
  int? schoolId;
  int? invoiceId;
  String? createdOn;
  String? refundDate;
  int? refundMethodId;
  int? reasonId;
  String? refundMemo;
  double? amount;

  factory RefundModel.fromJson(Map<String, dynamic> json) => RefundModel(
        id: json["id"],
        schoolId: json["schoolId"],
        invoiceId: json["invoiceId"],
        createdOn: json["createdOn"],
        refundDate: json["refundDate"],
        refundMethodId: json["refundMethodId"],
        reasonId: json["reasonId"],
        refundMemo: json["refundMemo"],
        amount: json["amount"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "schoolId": schoolId,
        "invoiceId": invoiceId,
        "createdOn": createdOn,
        "refundDate": refundDate,
        "refundMethodId": refundMethodId,
        "reasonId": reasonId,
        "refundMemo": refundMemo,
        "amount": amount,
      };
}
