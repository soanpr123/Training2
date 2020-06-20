class AddressHotelsModel {
  String status;
  Data data;
  String message;
  dynamic userContext;
  bool failed;
  bool success;

  AddressHotelsModel({
    this.status,
    this.data,
    this.message,
    this.userContext,
    this.failed,
    this.success,
  });

  factory AddressHotelsModel.fromJson(Map<String, dynamic> json) => AddressHotelsModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        userContext: json["userContext"],
        failed: json["failed"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
        "userContext": userContext,
        "failed": failed,
        "success": success,
      };
}

class Data {
  HotelContent hotelContent;
  AreaRecommendationContent areaRC;

  Data({
    this.hotelContent,
    this.areaRC,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hotelContent: HotelContent.fromJson(json["hotelContent"]),
        areaRC: AreaRecommendationContent.fromJson(
            json["areaRecommendationContent"]),
      );

  Map<String, dynamic> toJson() => {
        "hotelContent": hotelContent.toJson(),
        "areaRecommendationContent": areaRC.toJson(),
      };
}

class AreaRecommendationContent {
  String geoName;
  List<AreaRecommendationContentRow> areaRecommendationContentRow;

  AreaRecommendationContent({
    this.geoName,
    this.areaRecommendationContentRow,
  });

  factory AreaRecommendationContent.fromJson(Map<String, dynamic> json) =>
      AreaRecommendationContent(
        geoName: json["geoName"],
        areaRecommendationContentRow: List<AreaRecommendationContentRow>.from(
            json["rows"].map((x) => AreaRecommendationContentRow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "geoName": geoName,
        "rows": List<dynamic>.from(
            areaRecommendationContentRow.map((x) => x.toJson())),
      };
}

class AreaRecommendationContentRow {
  String type;
  String name;
  String displayName;
  String additionalInfo;
  GeoLocation geoLocation;
  String localeDisplayType;
  String minimumPrice;
  String numHotels;
  String imageUrl;
  String percentStay;
  String geoId;

  AreaRecommendationContentRow({
    this.type,
    this.name,
    this.displayName,
    this.additionalInfo,
    this.geoLocation,
    this.localeDisplayType,
    this.minimumPrice,
    this.numHotels,
    this.imageUrl,
    this.percentStay,
    this.geoId,
  });

  factory AreaRecommendationContentRow.fromJson(Map<String, dynamic> json) =>
      AreaRecommendationContentRow(
        type: json["type"],
        name: json["name"],
        displayName: json["displayName"],
        additionalInfo: json["additionalInfo"],
        geoLocation: GeoLocation.fromJson(json["geoLocation"]),
        localeDisplayType: json["localeDisplayType"],
        minimumPrice: json["minimumPrice"],
        numHotels: json["numHotels"],
        imageUrl: json["imageURL"],
        percentStay: json["percentStay"],
        geoId: json["geoId"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "displayName": displayName,
        "additionalInfo": additionalInfo,
        "geoLocation": geoLocation.toJson(),
        "localeDisplayType": localeDisplayType,
        "minimumPrice": minimumPrice,
        "numHotels": numHotels,
        "imageURL": imageUrl,
        "percentStay": percentStay,
        "geoId": geoId,
      };
}

class GeoLocation {
  String lon;
  String lat;
  bool valid;

  GeoLocation({
    this.lon,
    this.lat,
    this.valid,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        lon: json["lon"],
        lat: json["lat"],
        valid: json["valid"],
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
        "valid": valid,
      };
}

class HotelContent {
  List<HotelContentRow> hotelContentRow;

  HotelContent({
    this.hotelContentRow,
  });

  factory HotelContent.fromJson(Map<String, dynamic> json) => HotelContent(
        hotelContentRow: List<HotelContentRow>.from(
            json["rows"].map((x) => HotelContentRow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rows": List<dynamic>.from(hotelContentRow.map((x) => x.toJson())),
      };
}

class HotelContentRow {
  String id;
  dynamic placeId;
  Type type;
  String name;
  dynamic numberOfHotel;
  String numHotels;
  String targetUrl;
  dynamic landmarkType;
  Type accommodationType;
  GeoLocation geoLocation;
  String matchingScore;
  bool searchByFormerlyName;
  LocaleDisplayType localeDisplayType;
  String displayName;
  String globalName;
  String additionalInfo;
  dynamic distance;

  HotelContentRow({
    this.id,
    this.placeId,
    this.type,
    this.name,
    this.numberOfHotel,
    this.numHotels,
    this.targetUrl,
    this.landmarkType,
    this.accommodationType,
    this.geoLocation,
    this.matchingScore,
    this.searchByFormerlyName,
    this.localeDisplayType,
    this.displayName,
    this.globalName,
    this.additionalInfo,
    this.distance,
  });

  factory HotelContentRow.fromJson(Map<String, dynamic> json) =>
      HotelContentRow(
        id: json["id"],
        placeId: json["placeId"],
        type: typeValues.map[json["type"]],
        name: json["name"],
        numberOfHotel: json["numberOfHotel"],
        numHotels: json["numHotels"],
        targetUrl: json["targetUrl"],
        landmarkType: json["landmarkType"],
        accommodationType: typeValues.map[json["accommodationType"]],
        geoLocation: GeoLocation.fromJson(json["geoLocation"]),
        matchingScore: json["matchingScore"],
        searchByFormerlyName: json["searchByFormerlyName"],
        localeDisplayType:
            localeDisplayTypeValues.map[json["localeDisplayType"]],
        displayName: json["displayName"],
        globalName: json["globalName"],
        additionalInfo: json["additionalInfo"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "placeId": placeId,
        "type": typeValues.reverse[type],
        "name": name,
        "numberOfHotel": numberOfHotel,
        "numHotels": numHotels,
        "targetUrl": targetUrl,
        "landmarkType": landmarkType,
        "accommodationType": typeValues.reverse[accommodationType],
        "geoLocation": geoLocation.toJson(),
        "matchingScore": matchingScore,
        "searchByFormerlyName": searchByFormerlyName,
        "localeDisplayType": localeDisplayTypeValues.reverse[localeDisplayType],
        "displayName": displayName,
        "globalName": globalName,
        "additionalInfo": additionalInfo,
        "distance": distance,
      };
}

enum Type { HOTEL }

final typeValues = EnumValues({"HOTEL": Type.HOTEL});

enum LocaleDisplayType { KHCH_SN }

final localeDisplayTypeValues =
    EnumValues({"Khách sạn": LocaleDisplayType.KHCH_SN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
