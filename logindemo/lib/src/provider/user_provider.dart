import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logindemo/src/models/user.dart';

class UserProvider with ChangeNotifier {
  List<DatumUser> _users = [];
  String token;

  List<DatumUser> get users => _users;

  UserProvider(this.token);
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Content-type': 'application/json'
  };

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  Future<void> fetchUser({Function onSucess(object)}) async {
    final url = 'https://uoi.bachasoftware.com/api/user/updateStatus';
    try {
      final response = await http.post(url,
          headers: requestHeaders, body: json.encode({'token': token}));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData == null) {
        return;
      }
      List<DatumUser> loaderUser = [];

      UserMd userMd = UserMd.fromJson(responseData);
      if (userMd.data.length > 0) {
        for (DatumUser _uesr1 in userMd.data) {
          loaderUser.add(DatumUser(
              id: _uesr1.id,
              firstname: _uesr1.firstname,
              lastname: _uesr1.lastname,
              displayname: _uesr1.displayname,
              status: _uesr1.status,
              avatars: _uesr1.avatars,
              email: _uesr1.email));
         onSucess(_uesr1);
        }

        _users = loaderUser;
        print(_users.length);
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}

