import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_travel/src/model/base_model/error_message.dart';
import 'package:my_travel/src/shared/style/cookie.dart';

class BaseService {
  sendPostRequest(String contentUrl, Map data,String domain, Function successBlock(object),
      Function failBlock(error)) async {
    String url = contentUrl;
    print(url);
    var body = json.encode(data);
    var response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
      "Host": "www.traveloka.com",
      "Origin": "https://www.traveloka.com",
      "x-domain": domain,
      "Cookie": cookie.cookie,
      "x-route-prefix": "vi-vn"
    });
    if (response.statusCode == 200) {
      //kết nối thành công
      var dataJson = await json.decode(response.body);
      print(dataJson);

      if (dataJson['status'] == 'SUCCESS') {
        //action = 1
        if (dataJson['data'] != null) {
          print(dataJson['data']);
          return successBlock(dataJson);
        } else {
          var error = ErrorMessage(
              status: dataJson['status'],
              message: "Cannot get response, please try again later!");
          return failBlock(error);
        }
      } else {
        //action != 1
        var error = ErrorMessage(
            status: dataJson['status'], message: dataJson['message']);
        return failBlock(error);
      }
    } else {
      //nếu kết nối lỗi
      var error = ErrorMessage(
          status: response.statusCode.toString(),
          message: "System busy, please try again later!");
      return failBlock(error);
    }
  }
}
