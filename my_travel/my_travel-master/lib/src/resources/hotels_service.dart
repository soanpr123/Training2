import 'dart:convert';

import 'package:my_travel/src/model/hotel_addressmodel.dart';
import 'package:my_travel/src/model/hotels_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_travel/src/model/rooms_hotels_models.dart';
import 'package:my_travel/src/shared/style/cookie.dart';
import 'Base_service.dart';

class HotelsService {
  void getAddressHotels(String nameCity, Function successBlock(object),
      Function failBlock(error)) async {
    var params = "https://www.traveloka.com/api/v1/hotel/autocomplete";
    Map data = {
      "clientInterface": "desktop",
      "data": {"query": nameCity},
      "fields": []
    };

    BaseService().sendPostRequest(params, data, "accomContent", (dataJson) {
      return successBlock(AddressHotelsModel.fromJson(dataJson));
    }, (error) {
      return failBlock(error);
    });
  }

  Future<HotelsModel> getHotels(
      String geoId,
      String nameCity,
      String sourceType,
      int yearStart,
      int monthStart,
      int daysStart,
      int yearEnd,
      int monthEnd,
      int daysEnd) async {
    final params = "https://www.traveloka.com/api/v2/hotel/search";
    Map data = {
      "clientInterface": "desktop",
      "data": {
        "checkInDate": {
          "year": yearStart,
          "month": monthStart,
          "day": daysStart
        },
        "checkOutDate": {"year": yearEnd, "month": monthEnd, "day": daysEnd},
        "numOfNights": 1,
        "currency": "VND",
        "numAdults": 1,
        "numChildren": 0,
        "childAges": [],
        "numInfants": 0,
        "numRooms": 1,
        "ccGuaranteeOptions": {
          "ccInfoPreferences": ["CC_TOKEN", "CC_FULL_INFO"],
          "ccGuaranteeRequirementOptions": ["CC_GUARANTEE"]
        },
        "rateTypes": ["PAY_NOW", "PAY_AT_PROPERTY"],
        "isJustLogin": false,
        "backdate": false,
        "geoId": geoId,
        "geoLocation": null,
        "monitoringSpec": {
          "lastKeyword": nameCity,
          "referrer": "https://www.traveloka.com/vi-vn/",
          "searchId": null,
          "searchFunnelType": null,
          "isPriceFinderActive": "true",
          "dateIndicator": "undefined",
          "bannerMessage": "undefined",
          "displayPrice": null
        },
        "showHidden": false,
        "locationName": nameCity,
        "sourceType": sourceType,
        "boundaries": null,
        "contexts": {"isFamilyCheckbox": false},
        "basicFilterSortSpec": {
          "accommodationTypeFilter": [],
          "ascending": false,
          "basicSortType": "POPULARITY",
          "facilityFilter": [],
          "maxPriceFilter": null,
          "minPriceFilter": null,
          "quickFilterId": null,
          "skip": 0,
          "starRatingFilter": [true, true, true, true, true],
          "top": 100
        },
        "criteriaFilterSortSpec": null,
        "isExtraBedIncluded": true,
        "uniqueSearchId": null
      },
      "fields": []
    };

    var body = json.encode(data);
    var response = await http.post(params, body: body, headers: {
      "Content-Type": "application/json",
      "Host": "www.traveloka.com",
      "Origin": "https://www.traveloka.com",
      "x-domain": "accomSearch",
      "Cookie": cookie.cookie,
      "x-route-prefix": "vi-vn"
    });
    if (response.statusCode == 200) {
      return HotelsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  

  Future<RoomsHotelsModels> getRoomsHotels(
      String idHotels,
      int yearStart,
      int monthStart,
      int daysStart,
      int yearEnd,
      int monthEnd,
      int daysEnd) async {
    final url = "https://www.traveloka.com/api/v2/hotel/searchRooms";
    Map data = {
      "clientInterface": "desktop",
      "data": {
        "checkInDate": {"year": yearStart, "month": monthStart, "day": daysStart},
        "checkOutDate": {"year": yearEnd, "month": monthEnd, "day": daysEnd},
        "numOfNights": 2,
        "currency": "VND",
        "numAdults": 3,
        "numChildren": 0,
        "childAges": [],
        "numInfants": 0,
        "numRooms": 2,
        "ccGuaranteeOptions": {
          "ccInfoPreferences": ["CC_TOKEN", "CC_FULL_INFO"],
          "ccGuaranteeRequirementOptions": ["CC_GUARANTEE"]
        },
        "rateTypes": ["PAY_NOW", "PAY_AT_PROPERTY"],
        "isJustLogin": false,
        "contexts": {"shouldDisplayAllRooms": false, "bookingId": null},
        "hotelId": idHotels,
        "labelContext": {},
        "monitoringSpec": {
          "lastKeyword": "FLC Halong Bay Golf Club & Luxury Resort",
          "referrer":
              "https://www.traveloka.com/vi-vn/hotel/search?spec=$daysStart-$monthStart-$yearStart.$daysEnd-$monthEnd-$yearEnd.2.2.HOTEL_GEO.30010278.Th%C3%A0nh%20ph%E1%BB%91%20H%E1%BA%A1%20Long..3",
          "isPriceFinderActive": "null",
          "dateIndicator": "null",
          "displayPrice": "null"
        },
        "prevSearchId": "1651787974436738709",
        "preview": false,
        "isReschedule": false,
        "isExtraBedIncluded": true,
        "hasPromoLabel": true
      },
      "fields": []
    };
    var body = json.encode(data);
    var response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
      "Host": "www.traveloka.com",
      "Origin": "https://www.traveloka.com",
      "x-domain": "accomSearch",
      "Cookie": cookie.cookie,
      "x-route-prefix": "vi-vn"
    });
    if (response.statusCode == 200) {
      print(response.body);
      return RoomsHotelsModels.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
