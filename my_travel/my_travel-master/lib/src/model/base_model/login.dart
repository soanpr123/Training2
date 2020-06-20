class LoginModel {
  String message;
  List<DatumLogin> data;

  LoginModel({
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        data: List<DatumLogin>.from(json["data"].map((x) => DatumLogin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumLogin {
  String id;
  String name;
  String avatar;
  String email;
  String password;

  DatumLogin({
    this.id,
    this.name,
    this.avatar,
    this.email,
    this.password,
  });

  factory DatumLogin.fromJson(Map<String, dynamic> json) => DatumLogin(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "email": email,
        "password": password,
      };
}
