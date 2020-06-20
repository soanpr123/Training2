// To parse this JSON data, do
//
//     final codeAirportModel = codeAirportModelFromJson(jsonString);

import 'dart:convert';

CodeAirportModel codeAirportModelFromJson(String str) => CodeAirportModel.fromJson(json.decode(str));

String codeAirportModelToJson(CodeAirportModel data) => json.encode(data.toJson());

class CodeAirportModel {
	Data data;
	dynamic userContext;
	
	CodeAirportModel({
		this.data,
		this.userContext,
	});
	
	factory CodeAirportModel.fromJson(Map<String, dynamic> json) => CodeAirportModel(
		data: Data.fromJson(json["data"]),
		userContext: json["userContext"],
	);
	
	Map<String, dynamic> toJson() => {
		"data": data.toJson(),
		"userContext": userContext,
	};
}

class Data {
	List<dynamic> frequentAirportOrArea;
	List<dynamic> popularAirportOrArea;
	List<RecommendationAirportOrArea> recommendationAirportOrArea;
	String query;
	String locale;
	
	Data({
		this.frequentAirportOrArea,
		this.popularAirportOrArea,
		this.recommendationAirportOrArea,
		this.query,
		this.locale,
	});
	
	factory Data.fromJson(Map<String, dynamic> json) => Data(
		frequentAirportOrArea: List<dynamic>.from(json["frequentAirportOrArea"].map((x) => x)),
		popularAirportOrArea: List<dynamic>.from(json["popularAirportOrArea"].map((x) => x)),
		recommendationAirportOrArea: List<RecommendationAirportOrArea>.from(json["recommendationAirportOrArea"].map((x) => RecommendationAirportOrArea.fromJson(x))),
		query: json["query"],
		locale: json["locale"],
	);
	
	Map<String, dynamic> toJson() => {
		"frequentAirportOrArea": List<dynamic>.from(frequentAirportOrArea.map((x) => x)),
		"popularAirportOrArea": List<dynamic>.from(popularAirportOrArea.map((x) => x)),
		"recommendationAirportOrArea": List<dynamic>.from(recommendationAirportOrArea.map((x) => x.toJson())),
		"query": query,
		"locale": locale,
	};
}

class RecommendationAirportOrArea {
	String code;
	AirportDisplay airportDisplay;
	dynamic areaDisplay;
	String source;
	String sourceValue;
	String score;
	
	RecommendationAirportOrArea({
		this.code,
		this.airportDisplay,
		this.areaDisplay,
		this.source,
		this.sourceValue,
		this.score,
	});
	
	factory RecommendationAirportOrArea.fromJson(Map<String, dynamic> json) => RecommendationAirportOrArea(
		code: json["code"],
		airportDisplay: AirportDisplay.fromJson(json["airportDisplay"]),
		areaDisplay: json["areaDisplay"],
		source: json["source"],
		sourceValue: json["sourceValue"],
		score: json["score"],
	);
	
	Map<String, dynamic> toJson() => {
		"code": code,
		"airportDisplay": airportDisplay.toJson(),
		"areaDisplay": areaDisplay,
		"source": source,
		"sourceValue": sourceValue,
		"score": score,
	};
}

class AirportDisplay {
	String code;
	String name;
	String location;
	String shortLocation;
	String uniqueUrlName;
	String country;
	String areaCode;
	dynamic airportIcaoCode;
	bool isKeyCity;
	dynamic domesticTaxWithCurrency;
	dynamic internationalTaxWithCurrency;
	dynamic geoLocation;
	bool keyCity;
	
	AirportDisplay({
		this.code,
		this.name,
		this.location,
		this.shortLocation,
		this.uniqueUrlName,
		this.country,
		this.areaCode,
		this.airportIcaoCode,
		this.isKeyCity,
		this.domesticTaxWithCurrency,
		this.internationalTaxWithCurrency,
		this.geoLocation,
		this.keyCity,
	});
	
	factory AirportDisplay.fromJson(Map<String, dynamic> json) => AirportDisplay(
		code: json["code"],
		name: json["name"],
		location: json["location"],
		shortLocation: json["shortLocation"],
		uniqueUrlName: json["uniqueUrlName"],
		country: json["country"],
		areaCode: json["areaCode"],
		airportIcaoCode: json["airportIcaoCode"],
		isKeyCity: json["isKeyCity"],
		domesticTaxWithCurrency: json["domesticTaxWithCurrency"],
		internationalTaxWithCurrency: json["internationalTaxWithCurrency"],
		geoLocation: json["geoLocation"],
		keyCity: json["keyCity"],
	);
	
	Map<String, dynamic> toJson() => {
		"code": code,
		"name": name,
		"location": location,
		"shortLocation": shortLocation,
		"uniqueUrlName": uniqueUrlName,
		"country": country,
		"areaCode": areaCode,
		"airportIcaoCode": airportIcaoCode,
		"isKeyCity": isKeyCity,
		"domesticTaxWithCurrency": domesticTaxWithCurrency,
		"internationalTaxWithCurrency": internationalTaxWithCurrency,
		"geoLocation": geoLocation,
		"keyCity": keyCity,
	};
}
