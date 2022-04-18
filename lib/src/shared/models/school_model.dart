import 'dart:convert';

import 'currency_model.dart';

List<SchoolModel> schoolFromJson(String str) => List<SchoolModel>.from(
    json.decode(str).map((x) => SchoolModel.fromJson(x)));
String schoolToJson(List<SchoolModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchoolModel {
  SchoolModel({
    required this.id,
    this.name,
    this.phone,
    this.address,
    this.email,
    this.website,
    this.currency,
    this.currencyId,
    this.terms,
    this.timeZoneId,
    this.isTutor,
    this.slug,
  });
  int id;
  String? name;
  String? phone;
  String? address;
  String? email;
  String? website;
  int? currencyId;
  String? terms;
  String? timeZoneId;
  bool? isTutor;
  String? slug;
  CurrencyModel? currency;

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        email: json["email"],
        website: json["website"],
        currencyId: json["currencyId"],
        currency: json['currency'],
        terms: json["terms"],
        timeZoneId: json["timeZoneId"],
        isTutor: json["isTutor"],
        slug: json["slug"],
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "phone": phone,
        "address": address,
        "email": email,
        "website": website,
        "currencyId": currencyId,
        "currency": currency,
        "terms": terms,
        "timeZoneId": timeZoneId,
        "isTutor": isTutor,
        "slug": slug,
      };
}
