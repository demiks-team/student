import 'dart:convert';

import 'course_material_page_content_model.dart';

List<CourseMaterialPageModel> invoiceFromJson(String str) =>
    List<CourseMaterialPageModel>.from(
        json.decode(str).map((x) => CourseMaterialPageModel.fromJson(x)));
String invoiceToJson(List<CourseMaterialPageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseMaterialPageModel {
  CourseMaterialPageModel(
      {required this.id,
      this.courseMaterialPageContent,
      this.courseMaterialId,
      this.courseMaterialPageContentId,
      this.pageNumber});
  int id;
  CourseMaterialPageContentModel? courseMaterialPageContent;
  int? courseMaterialId;
  int? courseMaterialPageContentId;
  int? pageNumber;
  factory CourseMaterialPageModel.fromJson(Map<String, dynamic> json) =>
      CourseMaterialPageModel(
        id: json["id"],
        courseMaterialPageContent: json["courseMaterialPageContent"] != null
            ? CourseMaterialPageContentModel.fromJson(
                json["courseMaterialPageContent"])
            : null,
        courseMaterialId: json["courseMaterialId"],
        courseMaterialPageContentId: json["courseMaterialPageContentId"],
        pageNumber: json["pageNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseMaterialPageContent": courseMaterialPageContent != null
            ? courseMaterialPageContent!.toJson()
            : null,
        "courseMaterialId": courseMaterialId,
        "courseMaterialPageContentId": courseMaterialPageContentId,
        "pageNumber": pageNumber,
      };
}
