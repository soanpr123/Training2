import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_travel/src/model/base_model/login.dart';
import 'package:my_travel/src/shared/toast.dart';

class LoginService {
  String url = "http://5dd659fece4c30001440372b.mockapi.io/api/v1";

  static String userID = "";
  static String typeFlight = "flight";
  static String typeHotel = "hotel";

  resign(
      {String username,
      String email,
      String password,
      String urlAvatar,
      Function successBloc(object),
      Function failBloc(error)}) async {
    String urlImage = urlAvatar != null
        ? urlAvatar
        : "https://img.lostbird.vn/600x-/2019/05/27/665573/trieu-lo-tu-15.jpg";

    String bEmail = email != null ? email : "";

    Map bodyData = {
      "name": "$username",
      "email": "$bEmail",
      "password": "$password",
      "avatar": "$urlImage"
    };
    DatumLogin datumLogin = DatumLogin();
    await login(
        username: username,
        password: password,
        status: true,
        successBloc: (data) {
          datumLogin = data;
          return;
        },
        failBloc: (err) {
          return;
        });

    if (datumLogin.name == username || datumLogin.email == email) {
      ToastShare().getToast("Tài khoản đã được đăng ký. Vui lòng đăng nhập");
      return null;
    }

    var response = await http.post(
      url + '/user',
      body: bodyData,
    );

    var dataJson = await jsonDecode(response.body);
    print(dataJson);

    if (dataJson['message'] == '1') {
      //action = 1
      return successBloc(true);
    } else {
      //action != 1
      ToastShare().getToast("Server error, please try again.");
      return failBloc(false);
    }
  }

  login(
      {String username,
      String password,
      bool status,
      Function successBloc(object),
      Function failBloc(error)}) async {
    var response = await http.get(
      url + '/user',
    );

    status = status != null ? status : false;

    var dataJson = await jsonDecode(response.body);
    print(dataJson);

    if (dataJson['message'] == '1') {
      //action = 1
      LoginModel loginModel = LoginModel.fromJson(dataJson);

      if (loginModel.data.length > 0) {
        for (DatumLogin item in loginModel.data) {
          if (item.email == username || item.name == username) {
            if (item.password == password) {
              userID = item.id;
              return successBloc(item);
            } else {
              if (!status) {
                ToastShare().getToast("Lỗi mật khẩu không đúng");
              }
              return failBloc(false);
            }
          } else {
            if (!status) {
              ToastShare().getToast("Sai tên tài khoản");
            }
            return failBloc(false);
          }
        }
      } else {
        if (!status) {
          ToastShare().getToast("Tài khoản chưa được đăng ký");
        }
        return failBloc(false);
      }
    } else {
      //action != 1
      if (!status) {
        ToastShare().getToast("Server error, please try again.");
      }
      return failBloc(false);
    }
  }
}
