import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logindemo/src/http_exception.dart';

import 'package:logindemo/src/style/toast.dart';

class Auth with ChangeNotifier {
  List<Account> _account = [];
  String _token;
  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  List<Account> get account => _account;

  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Content-type': 'application/json'
  };

  void sha512enCode(
      String token, String password, String passwordsha, String saltKey) {
    List<int> key = utf8.encode(saltKey);
    List<int> bytes = utf8.encode(password);
    var hmacSha256 = new Hmac(sha512, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    print(digest);
    print('passs so sanh :$passwordsha');
    if (digest.toString() == passwordsha) {
      List<Account> _loaderAcount = [];
      _loaderAcount.add(Account(webtoken: token));
      _account = _loaderAcount;
      _token = token;
      notifyListeners();
    } else {
      _token == null;
      _account.clear();
      ToastShare().getToast("Mật Khẩu Không chính xác");
      notifyListeners();
    }
  }

// ----------------------login to uoi---------------------------
  Future<void> _authenticate(String Email, String Password) async {
    final url = "https://uoi.bachasoftware.com/api/login";
    try {
      final response = await http.post(url,
          headers: requestHeaders,
          body: json.encode({
            'email': Email,
          }));
      final responseData = json.decode(response.body);
      if (responseData == null) {
        return;
      }
      sha512enCode(responseData['webToken'], Password, responseData['password'],
          responseData['saltKey']);
      if (responseData['error'] != null) {
        throw HttpException(responseData['message']);
      }
      if (responseData['message'] == 'not verified') {
        ToastShare().getToast("Email của bạn chưa được đăng kí");
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
  //-----------------------End Login------------------------------------
  //---------------------Signup------------------------------------------

  Future<void> singup(String email, String password) async {
    return _authenticate(email, password);
  }
}

class Account with ChangeNotifier {
  final String webtoken;
  Account({@required this.webtoken});
}
