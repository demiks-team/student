import 'dart:convert';


List<SchoolFeaturesModel> invoiceFromJson(String str) =>
    List<SchoolFeaturesModel>.from(
        json.decode(str).map((x) => SchoolFeaturesModel.fromJson(x)));
String invoiceToJson(List<SchoolFeaturesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchoolFeaturesModel {
  SchoolFeaturesModel({
    required this.schoolId,
    this.features,
  });
  int schoolId;
  List<String>? features;
  factory SchoolFeaturesModel.fromJson(Map<String, dynamic> json) =>
      SchoolFeaturesModel(
        schoolId: json["schoolId"],
        features: json["features"] != null
            ? (json["features"] as List)
                .map(
                  (dynamic item) => item.toString(),
                )
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        "schoolId": schoolId,
        if (features != null) "features": features else "features": null,
      };
}
