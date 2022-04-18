import 'dart:convert';

List<CurrencyModel> currencyFromJson(String str) => List<CurrencyModel>.from(
    json.decode(str).map((x) => CurrencyModel.fromJson(x)));
String currencyToJson(List<CurrencyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrencyModel {
  CurrencyModel({
    required this.id,
    this.name,
    this.displayOrder,
    this.currencyCode,
    this.displayFormat,
    this.sign,
  });
  int id;
  String? name;
  int? displayOrder;
  String? currencyCode;
  String? displayFormat;
  String? sign;
  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        id: json["id"],
        name: json["name"],
        displayOrder: json["displayOrder"],
        currencyCode: json["currencyCode"],
        displayFormat: json["displayFormat"],
        sign: json["sign"],
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "displayOrder": displayOrder,
        "currencyCode": currencyCode,
        "displayFormat": displayFormat,
        "sign": sign,
      };
}
