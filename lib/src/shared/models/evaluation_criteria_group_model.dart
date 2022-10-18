import 'dart:convert';


List<EvaluationCriteriaGroupModel> groupFromJson(String str) =>
    List<EvaluationCriteriaGroupModel>.from(json.decode(str).map((x) => EvaluationCriteriaGroupModel.fromJson(x)));
String groupToJson(List<EvaluationCriteriaGroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EvaluationCriteriaGroupModel {
  EvaluationCriteriaGroupModel({
    required this.id,
    this.title,
    this.result,
    this.passCondition,
  });
  int id;
  String? title;
  String? result;
  String? passCondition;
  factory EvaluationCriteriaGroupModel.fromJson(Map<String, dynamic> json) => EvaluationCriteriaGroupModel(
        id: json["id"],
        title: json["title"],
        result: json["result"],
        passCondition: json["passCondition"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "result": result,
        "passCondition": passCondition,
      };
}