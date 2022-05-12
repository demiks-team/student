import 'dart:convert';

List<SocialLoginModel> socialLoginFromJson(String str) =>
    List<SocialLoginModel>.from(
        json.decode(str).map((x) => SocialLoginModel.fromJson(x)));
String socialLoginToJson(List<SocialLoginModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SocialLoginModel {
  SocialLoginModel({
    this.id,
    this.email,
    this.token,
    this.name,
    this.image,
    this.provider,
    this.idToken,
  });

  String? id;
  String? email;
  String? token;
  String? name;
  String? image;
  String? provider;
  String? idToken;

  factory SocialLoginModel.fromJson(Map<String, dynamic> json) =>
      SocialLoginModel(
        id: json["id"],
        email: json["email"],
        token: json["token"],
        name: json["name"],
        image: json["image"],
        provider: json["provider"],
        idToken: json["idToken"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "token": token,
        "name": name,
        "image": image,
        "provider": provider,
        "idToken": idToken,
      };
}
