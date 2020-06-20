import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_travel/src/model/travel_model.dart';

class TravelService {
  Future<TravelModel> getTravel() async {
    final url = "http://5dd659fece4c30001440372b.mockapi.io/api/v1/best-destinations";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return TravelModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load post');
    }
  }
  
}
