import 'dart:convert';

List<RoomModel> roomFromJson(String str) =>
    List<RoomModel>.from(json.decode(str).map((x) => RoomModel.fromJson(x)));
String roomToJson(List<RoomModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomModel {
  RoomModel({
    required this.id,
    this.title,
  });
  int id;
  String? title;

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        id: json["id"],
        title: json["title"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
