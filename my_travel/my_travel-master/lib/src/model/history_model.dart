class HistoryModel {
  String message;
  List<History> data;

  HistoryModel({
    this.message,
    this.data,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        message: json["message"],
        data: List<History>.from(json["data"].map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class History {
  String id;
  String userId;
  String titleFlight;
  String cityStartFlight;
  String cityEndFlight;
  String nameFlightStartFlight;
  String nameFlightEndFlight;
  String codeFlight;
  String dateStartFlight;
  String dateEndFlight;
  String priceFlight;
  String quantityFlight;
  String iconFlight;
  String type;
  String imageHotel;
  String titleHotel;
  String regionHotel;
  String priceHotel;
  String starRatingHotel;
//  List<dynamic> imagesHotel;

  History({
    this.id,
    this.userId,
    this.titleFlight,
    this.cityStartFlight,
    this.cityEndFlight,
    this.nameFlightStartFlight,
    this.nameFlightEndFlight,
    this.codeFlight,
    this.dateStartFlight,
    this.dateEndFlight,
    this.priceFlight,
    this.quantityFlight,
    this.iconFlight,
    this.type,
    this.imageHotel,
    this.titleHotel,
    this.regionHotel,
    this.priceHotel,
    this.starRatingHotel,
//    this.imagesHotel,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userId: json["userId"],
        titleFlight: json["titleFlight"],
        cityStartFlight: json["cityStartFlight"],
        cityEndFlight: json["cityEndFlight"],
        nameFlightStartFlight: json["nameFlightStartFlight"],
        nameFlightEndFlight: json["nameFlightEndFlight"],
        codeFlight: json["codeFlight"],
        dateStartFlight: json["dateStartFlight"],
        dateEndFlight: json["dateEndFlight"],
        priceFlight: json["priceFlight"],
        quantityFlight: json["quantityFlight"],
        iconFlight: json["iconFlight"],
        type: json["type"],
        imageHotel: json["imageHotel"],
        titleHotel: json["titleHotel"],
        regionHotel: json["regionHotel"],
        priceHotel: json["priceHotel"],
        starRatingHotel: json["starRatingHotel"],
//        imagesHotel: List<dynamic>.from(json["imagesHotel"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "titleFlight": titleFlight,
        "cityStartFlight": cityStartFlight,
        "cityEndFlight": cityEndFlight,
        "nameFlightStartFlight": nameFlightStartFlight,
        "nameFlightEndFlight": nameFlightEndFlight,
        "codeFlight": codeFlight,
        "dateStartFlight": dateStartFlight,
        "dateEndFlight": dateEndFlight,
        "priceFlight": priceFlight,
        "quantityFlight": quantityFlight,
        "iconFlight": iconFlight,
        "type": type,
        "imageHotel": imageHotel,
        "titleHotel": titleHotel,
        "regionHotel": regionHotel,
        "priceHotel": priceHotel,
        "starRatingHotel": starRatingHotel,
//        "imagesHotel": List<dynamic>.from(imagesHotel.map((x) => x)),
      };
}
