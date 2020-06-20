import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_travel/src/model/code_airport_model.dart';
import 'package:my_travel/src/model/flight_model.dart';
import 'package:my_travel/src/model/flight_one_way_model.dart';
import 'package:my_travel/src/model/history_model.dart';
import 'package:my_travel/src/shared/style/cookie.dart';

import 'login_service.dart';

class FlightService {
  Future<CodeAirportModel> getCodeAirportModel(String searchCity) async {
    final url = "https://www.traveloka.com/api/v2/airport/autocomplete";

    Map data = {
      "clientInterface": "desktop",
      "data": {"query": searchCity},
      "fields": []
    };
    var body = json.encode(data);
    var response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
      "Host": "www.traveloka.com",
      "Origin": "https://www.traveloka.com",
      "x-domain": "flightDiscovery",
      "Cookie": cookie.cookie,
      "x-route-prefix": "vi-vn"
    });
    if (response.statusCode == 200) {
      return CodeAirportModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<DataFlight> getFlight(String startCode, String endCode, String numAdults, String yearStart,
      String monthStart, String dayStart, String yearEnd, String monthEnd, String dayEnd) async {
    final url = "https://www.traveloka.com/api/v2/flight/search/return2w";

    Map data = {
      "clientInterface": "desktop",
      "data": {
        "airportOrAreaCodes": [startCode, endCode],
        "currency": "VND",
        "destinationAirportOrArea": endCode,
        "dates": [
          {"day": dayStart, "month": monthStart, "year": yearStart},
          {"day": dayEnd, "month": monthEnd, "year": yearEnd}
        ],
        "flightDate": {"day": dayEnd, "month": monthEnd, "year": yearEnd},
        "locale": "vi_VN",
        "newResult": true,
        "numSeats": {"numAdults": "1", "numChildren": "0", "numInfants": "0"},
        "seatPublishedClass": "ECONOMY",
        "seqNo": null,
        "sortFilter": {
          "filterAirlines": [],
          "filterArrive": [],
          "filterDepart": [],
          "filterTransit": [],
          "selectedDeparture": "",
          "sort": null
        },
        "sourceAirportOrArea": startCode,
        "searchId": null,
        "usePromoFinder": false,
        "useDateFlow": false,
        "visitId": "ffd25df2-bf23-4b25-8815-55cdb5470022"
      },
      "fields": []
    };
    var body = json.encode(data);
    var response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
      "Host": "www.traveloka.com",
      "Origin": "https://www.traveloka.com",
      "x-domain": "flight",
      "Cookie": cookie.cookie,
      "x-route-prefix": "vi-vn"
    });
    if (response.statusCode == 200) {
      Map mapCodeFlight = jsonDecode(response.body);
      return DataFlight(
          flightModel: FlightModel.fromJson(json.decode(response.body)),
          b1: mapCodeFlight['data']['airlineDataMap'],
          airportDataMap: mapCodeFlight['data']['airportDataMap']);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<DataFlight2> getFlight1(String startCode, String endCode, String yearStart,
      String monthStart, String dayStart) async {
    final url = "https://www.traveloka.com/api/v2/flight/search/oneway";

    Map data = {
      "clientInterface": "desktop",
      "data": {
        "currency": "VND",
        "destinationAirportOrArea": endCode,
        "flightDate": {"day": dayStart, "month": monthStart, "year": yearStart},
        "locale": "vi_VN",
        "newResult": true,
        "numSeats": {"numAdults": "1", "numChildren": "0", "numInfants": "0"},
        "seatPublishedClass": "ECONOMY",
        "seqNo": null,
        "sortFilter": {
          "filterAirlines": [],
          "filterArrive": [],
          "filterDepart": [],
          "filterTransit": [],
          "selectedDeparture": "",
          "sort": null
        },
        "sourceAirportOrArea": startCode,
        "searchId": null,
        "usePromoFinder": false,
        "useDateFlow": true,
        "visitId": "54223bb0-eb72-4e85-a39e-b3b1e1988830"
      },
      "fields": []
    };

    var body = json.encode(data);

    var response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
      "Host": "www.traveloka.com",
      "Origin": "https://www.traveloka.com",
      "x-domain": "flight",
      "Cookie": cookie.cookie,
      "x-route-prefix": "vi-vn",
    });

    if (response.statusCode == 200) {
      Map mapCodeFlight = jsonDecode(response.body);
      return DataFlight2(
          flightModel: FlightOneWayModel.fromJson(json.decode(response.body)),
          b1: mapCodeFlight['data']['airlineDataMap'],
          airportDataMap: mapCodeFlight['data']['airportDataMap']);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<bool> addHistory(
      {String userID,
      String type,
      String titleFlight,
      String cityStartFlight,
      String cityEndFlight,
      String nameFlightStartFlight,
      String nameFlightEndFlight,
      String codeFlight,
      String dateStartFlight,
      String dateEndFlight,
      String priceFlight,
      String quantityFlight,
      String iconFlight,
      String imageHotel,
      String titleHotel,
      String regionHotel,
      String priceHotel,
      String starRatingHotel,
      var imagesHotel}) async {
    final url =
        "http://5dd659fece4c30001440372b.mockapi.io/api/v1/user/${LoginService.userID}/history-flight";

    Map body = {
      "titleFlight": titleFlight != null ? titleFlight : "",
      "cityStartFlight": cityStartFlight != null ? cityStartFlight : "",
      "cityEndFlight": cityEndFlight != null ? cityEndFlight : "",
      "nameFlightStartFlight": nameFlightStartFlight != null ? nameFlightStartFlight : "",
      "nameFlightEndFlight": nameFlightEndFlight != null ? nameFlightEndFlight : "",
      "codeFlight": codeFlight != null ? codeFlight : "",
      "dateStartFlight": dateStartFlight != null ? dateStartFlight : "",
      "dateEndFlight": dateEndFlight != null ? dateEndFlight : "",
      "priceFlight": priceFlight != null ? priceFlight : "",
      "quantityFlight": quantityFlight != null ? quantityFlight : "",
      "iconFlight": iconFlight != null ? iconFlight : "",
      "type": type,
      "imageHotel": imageHotel != null ? imageHotel : "",
      "titleHotel": titleHotel != null ? titleHotel : "",
      "regionHotel": regionHotel != null ? regionHotel : "",
      "priceHotel": priceHotel != null ? priceHotel : "",
      "starRatingHotel": starRatingHotel != null ? starRatingHotel : "",
      "imagesHotel": imagesHotel != null ? jsonEncode(imagesHotel) : jsonEncode([])
    };

    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<HistoryModel> getHistory({String userID}) async {
    final url = "http://5dd659fece4c30001440372b.mockapi.io/api/v1/user/$userID/history-flight";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return HistoryModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }
}
