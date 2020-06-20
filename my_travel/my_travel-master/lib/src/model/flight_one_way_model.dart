class FlightOneWayModel {
	Data data;
	dynamic userContext;
	
	FlightOneWayModel({
		this.data,
		this.userContext,
	});
	
	factory FlightOneWayModel.fromJson(Map<String, dynamic> json) => FlightOneWayModel(
		data: Data.fromJson(json["data"]),
		userContext: json["userContext"],
	);
	
	Map<String, dynamic> toJson() => {
		"data": data.toJson(),
		"userContext": userContext,
	};
}

class Data {
	bool searchCompleted;
	dynamic seqNo;
	String searchId;
	dynamic searchResponseMessage;
	dynamic funnelSource;
	dynamic funnelId;
	String currency;
	String currencyDecimalPlaces;
	Map<String, Bl2> airlineDataMap;
	Map<String, AirportDataMap2> airportDataMap;
	FlightSeoInfo flightSeoInfo;
	String loyaltyPointEligibility;
	bool searchRanking;
	List<SearchResult2> searchResults;
	
	Data({
		this.searchCompleted,
		this.seqNo,
		this.searchId,
		this.searchResponseMessage,
		this.funnelSource,
		this.funnelId,
		this.currency,
		this.currencyDecimalPlaces,
		this.airlineDataMap,
		this.airportDataMap,
		this.flightSeoInfo,
		this.loyaltyPointEligibility,
		this.searchRanking,
		this.searchResults,
	});
	
	factory Data.fromJson(Map<String, dynamic> json) => Data(
		searchCompleted: json["searchCompleted"],
		seqNo: json["seqNo"],
		searchId: json["searchId"],
		searchResponseMessage: json["searchResponseMessage"],
		funnelSource: json["funnelSource"],
		funnelId: json["funnelId"],
		currency: json["currency"],
		currencyDecimalPlaces: json["currencyDecimalPlaces"],
		airlineDataMap: Map.from(json["airlineDataMap"]).map((k, v) => MapEntry<String, Bl2>(k, Bl2.fromJson(v))),
		airportDataMap: Map.from(json["airportDataMap"]).map((k, v) => MapEntry<String, AirportDataMap2>(k, AirportDataMap2.fromJson(v))),
		flightSeoInfo: FlightSeoInfo.fromJson(json["flightSeoInfo"]),
		loyaltyPointEligibility: json["loyaltyPointEligibility"],
		searchRanking: json["searchRanking"],
		searchResults: List<SearchResult2>.from(json["searchResults"].map((x) => SearchResult2.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"searchCompleted": searchCompleted,
		"seqNo": seqNo,
		"searchId": searchId,
		"searchResponseMessage": searchResponseMessage,
		"funnelSource": funnelSource,
		"funnelId": funnelId,
		"currency": currency,
		"currencyDecimalPlaces": currencyDecimalPlaces,
		"airlineDataMap": airlineDataMap,
		"airportDataMap": Map.from(airportDataMap).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
		"flightSeoInfo": flightSeoInfo.toJson(),
		"loyaltyPointEligibility": loyaltyPointEligibility,
		"searchRanking": searchRanking,
		"searchResults": List<dynamic>.from(searchResults.map((x) => x.toJson())),
	};
}

class Bl2 {
	String airlineId;
	String name;
	String shortName;
	String iconUrl;
	String iataCode;
	
	Bl2({
		this.airlineId,
		this.name,
		this.shortName,
		this.iconUrl,
		this.iataCode,
	});
	
	factory Bl2.fromJson(Map<String, dynamic> json) => Bl2(
		airlineId: json["airlineId"],
		name: json["name"],
		shortName: json["shortName"],
		iconUrl: json["iconUrl"],
		iataCode: json["iataCode"],
	);
	
	Map<String, dynamic> toJson() => {
		"airlineId": airlineId,
		"name": name,
		"shortName": shortName,
		"iconUrl": iconUrl,
		"iataCode": iataCode,
	};
}

class AirportDataMap2 {
	String airportId;
	String localName;
	String city;
	String country;
	
	AirportDataMap2({
		this.airportId,
		this.localName,
		this.city,
		this.country,
	});
	
	factory AirportDataMap2.fromJson(Map<String, dynamic> json) => AirportDataMap2(
		airportId: json["airportId"],
		localName: json["localName"],
		city: json["city"],
		country: json["country"],
	);
	
	Map<String, dynamic> toJson() => {
		"airportId": airportId,
		"localName": localName,
		"city": city,
		"country": country,
	};
}


class FlightSeoInfo {
	String url;
	String title;
	String description;
	
	FlightSeoInfo({
		this.url,
		this.title,
		this.description,
	});
	
	factory FlightSeoInfo.fromJson(Map<String, dynamic> json) => FlightSeoInfo(
		url: json["url"],
		title: json["title"],
		description: json["description"],
	);
	
	Map<String, dynamic> toJson() => {
		"url": url,
		"title": title,
		"description": description,
	};
}

class SearchResult2 {
	List<ConnectingFlightRoute> connectingFlightRoutes;
	List<FlightMetadatum> flightMetadata;
	String totalNumStop;
	bool mobileAppDeal;
	String tripDuration;
	AdditionalInfo additionalInfo;
	bool flexibleTicket;
	AirlineFareInfo airlineFareInfo;
	AgentFareInfo agentFareInfo;
	String flightId;
	DesktopPrice desktopPrice;
	DesktopPrice mAppsPrice;
	dynamic deltaPrice;
	dynamic bundleFareInfo;
	String loyaltyPoint;
	String score;
	
	SearchResult2({
		this.connectingFlightRoutes,
		this.flightMetadata,
		this.totalNumStop,
		this.mobileAppDeal,
		this.tripDuration,
		this.additionalInfo,
		this.flexibleTicket,
		this.airlineFareInfo,
		this.agentFareInfo,
		this.flightId,
		this.desktopPrice,
		this.mAppsPrice,
		this.deltaPrice,
		this.bundleFareInfo,
		this.loyaltyPoint,
		this.score,
	});
	
	factory SearchResult2.fromJson(Map<String, dynamic> json) => SearchResult2(
		connectingFlightRoutes: List<ConnectingFlightRoute>.from(json["connectingFlightRoutes"].map((x) => ConnectingFlightRoute.fromJson(x))),
		flightMetadata: List<FlightMetadatum>.from(json["flightMetadata"].map((x) => FlightMetadatum.fromJson(x))),
		totalNumStop: json["totalNumStop"],
		mobileAppDeal: json["mobileAppDeal"],
		tripDuration: json["tripDuration"],
		additionalInfo: AdditionalInfo.fromJson(json["additionalInfo"]),
		flexibleTicket: json["flexibleTicket"],
		airlineFareInfo: AirlineFareInfo.fromJson(json["airlineFareInfo"]),
		agentFareInfo: AgentFareInfo.fromJson(json["agentFareInfo"]),
		flightId: json["flightId"],
		desktopPrice: DesktopPrice.fromJson(json["desktopPrice"]),
		mAppsPrice: DesktopPrice.fromJson(json["mAppsPrice"]),
		deltaPrice: json["deltaPrice"],
		bundleFareInfo: json["bundleFareInfo"],
		loyaltyPoint: json["loyaltyPoint"],
		score: json["score"],
	);
	
	Map<String, dynamic> toJson() => {
		"connectingFlightRoutes": List<dynamic>.from(connectingFlightRoutes.map((x) => x.toJson())),
		"flightMetadata": List<dynamic>.from(flightMetadata.map((x) => x.toJson())),
		"totalNumStop": totalNumStop,
		"mobileAppDeal": mobileAppDeal,
		"tripDuration": tripDuration,
		"additionalInfo": additionalInfo.toJson(),
		"flexibleTicket": flexibleTicket,
		"airlineFareInfo": airlineFareInfo.toJson(),
		"agentFareInfo": agentFareInfo.toJson(),
		"flightId": flightId,
		"desktopPrice": desktopPrice.toJson(),
		"mAppsPrice": mAppsPrice.toJson(),
		"deltaPrice": deltaPrice,
		"bundleFareInfo": bundleFareInfo,
		"loyaltyPoint": loyaltyPoint,
		"score": score,
	};
}

class AdditionalInfo {
	String seatClassLabel;
	
	AdditionalInfo({
		this.seatClassLabel,
	});
	
	factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
		seatClassLabel: json["seatClassLabel"],
	);
	
	Map<String, dynamic> toJson() => {
		"seatClassLabel": seatClassLabel,
	};
}



class AgentFareInfo {
	DesktopPrice totalSearchFare;
	dynamic totalAdditionalFare;
	List<AgentFareInfoDetailedSearchFare> detailedSearchFares;
	
	AgentFareInfo({
		this.totalSearchFare,
		this.totalAdditionalFare,
		this.detailedSearchFares,
	});
	
	factory AgentFareInfo.fromJson(Map<String, dynamic> json) => AgentFareInfo(
		totalSearchFare: DesktopPrice.fromJson(json["totalSearchFare"]),
		totalAdditionalFare: json["totalAdditionalFare"],
		detailedSearchFares: List<AgentFareInfoDetailedSearchFare>.from(json["detailedSearchFares"].map((x) => AgentFareInfoDetailedSearchFare.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"totalSearchFare": totalSearchFare.toJson(),
		"totalAdditionalFare": totalAdditionalFare,
		"detailedSearchFares": List<dynamic>.from(detailedSearchFares.map((x) => x.toJson())),
	};
}

class AgentFareInfoDetailedSearchFare {
	AncillaryFare ancillaryFare;
	FlightRouteFares flightRouteFares;
	
	AgentFareInfoDetailedSearchFare({
		this.ancillaryFare,
		this.flightRouteFares,
	});
	
	factory AgentFareInfoDetailedSearchFare.fromJson(Map<String, dynamic> json) => AgentFareInfoDetailedSearchFare(
		ancillaryFare: AncillaryFare.fromJson(json["ancillaryFare"]),
		flightRouteFares: FlightRouteFares.fromJson(json["flightRouteFares"]),
	);
	
	Map<String, dynamic> toJson() => {
		"ancillaryFare": ancillaryFare.toJson(),
		"flightRouteFares": flightRouteFares.toJson(),
	};
}

class AncillaryFare {
	List<dynamic> addOnFares;
	List<dynamic> serviceFares;
	
	AncillaryFare({
		this.addOnFares,
		this.serviceFares,
	});
	
	factory AncillaryFare.fromJson(Map<String, dynamic> json) => AncillaryFare(
		addOnFares: List<dynamic>.from(json["addOnFares"].map((x) => x)),
		serviceFares: List<dynamic>.from(json["serviceFares"].map((x) => x)),
	);
	
	Map<String, dynamic> toJson() => {
		"addOnFares": List<dynamic>.from(addOnFares.map((x) => x)),
		"serviceFares": List<dynamic>.from(serviceFares.map((x) => x)),
	};
}

class FlightRouteFares {
	DesktopPrice adultAgentFare;
	DesktopPrice childAgentFare;
	DesktopPrice infantAgentFare;
	DesktopPrice adminFeeTotal;
	DesktopPrice totalFare;
	
	FlightRouteFares({
		this.adultAgentFare,
		this.childAgentFare,
		this.infantAgentFare,
		this.adminFeeTotal,
		this.totalFare,
	});
	
	factory FlightRouteFares.fromJson(Map<String, dynamic> json) => FlightRouteFares(
		adultAgentFare: DesktopPrice.fromJson(json["adultAgentFare"]),
		childAgentFare: DesktopPrice.fromJson(json["childAgentFare"]),
		infantAgentFare: DesktopPrice.fromJson(json["infantAgentFare"]),
		adminFeeTotal: DesktopPrice.fromJson(json["adminFeeTotal"]),
		totalFare: DesktopPrice.fromJson(json["totalFare"]),
	);
	
	Map<String, dynamic> toJson() => {
		"adultAgentFare": adultAgentFare.toJson(),
		"childAgentFare": childAgentFare.toJson(),
		"infantAgentFare": infantAgentFare.toJson(),
		"adminFeeTotal": adminFeeTotal.toJson(),
		"totalFare": totalFare.toJson(),
	};
}

class DesktopPrice {
	String currency;
	String amount;
	
	DesktopPrice({
		this.currency,
		this.amount,
	});
	
	factory DesktopPrice.fromJson(Map<String, dynamic> json) => DesktopPrice(
		currency: json["currency"],
		amount: json["amount"],
	);
	
	Map<String, dynamic> toJson() => {
		"currency": currency,
		"amount": amount,
	};
}

class AirlineFareInfo {
	DesktopPrice totalSearchFare;
	DesktopPrice totalAdditionalFare;
	List<AirlineFareInfoDetailedSearchFare> detailedSearchFares;
	
	AirlineFareInfo({
		this.totalSearchFare,
		this.totalAdditionalFare,
		this.detailedSearchFares,
	});
	
	factory AirlineFareInfo.fromJson(Map<String, dynamic> json) => AirlineFareInfo(
		totalSearchFare: DesktopPrice.fromJson(json["totalSearchFare"]),
		totalAdditionalFare: DesktopPrice.fromJson(json["totalAdditionalFare"]),
		detailedSearchFares: List<AirlineFareInfoDetailedSearchFare>.from(json["detailedSearchFares"].map((x) => AirlineFareInfoDetailedSearchFare.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"totalSearchFare": totalSearchFare.toJson(),
		"totalAdditionalFare": totalAdditionalFare.toJson(),
		"detailedSearchFares": List<dynamic>.from(detailedSearchFares.map((x) => x.toJson())),
	};
}

class AirlineFareInfoDetailedSearchFare {
	AncillaryFare ancillaryFare;
	Map<String, DesktopPrice> flightRouteFares;
	
	AirlineFareInfoDetailedSearchFare({
		this.ancillaryFare,
		this.flightRouteFares,
	});
	
	factory AirlineFareInfoDetailedSearchFare.fromJson(Map<String, dynamic> json) => AirlineFareInfoDetailedSearchFare(
		ancillaryFare: AncillaryFare.fromJson(json["ancillaryFare"]),
		flightRouteFares: Map.from(json["flightRouteFares"]).map((k, v) => MapEntry<String, DesktopPrice>(k, DesktopPrice.fromJson(v))),
	);
	
	Map<String, dynamic> toJson() => {
		"ancillaryFare": ancillaryFare.toJson(),
		"flightRouteFares": Map.from(flightRouteFares).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
	};
}

class ConnectingFlightRoute {
	String departureAirport;
	String arrivalAirport;
	String providerId;
	String dateTimeStamp;
	String numDayOffset;
	String totalNumStop;
	FlightRefundInfo flightRefundInfo;
	FlightRescheduleInfo flightRescheduleInfo;
	List<RouteInventory> routeInventories;
	List<Segment> segments;
	List<dynamic> promoLabels;
	String loyaltyPoint;
	
	ConnectingFlightRoute({
		this.departureAirport,
		this.arrivalAirport,
		this.providerId,
		this.dateTimeStamp,
		this.numDayOffset,
		this.totalNumStop,
		this.flightRefundInfo,
		this.flightRescheduleInfo,
		this.routeInventories,
		this.segments,
		this.promoLabels,
		this.loyaltyPoint,
	});
	
	factory ConnectingFlightRoute.fromJson(Map<String, dynamic> json) => ConnectingFlightRoute(
		departureAirport: json["departureAirport"],
		arrivalAirport: json["arrivalAirport"],
		providerId: json["providerId"],
		dateTimeStamp: json["dateTimeStamp"],
		numDayOffset: json["numDayOffset"],
		totalNumStop: json["totalNumStop"],
		segments: List<Segment>.from(json['segments'].map((x)=> Segment.fromJson(x))),
		flightRefundInfo: FlightRefundInfo.fromJson(json["flightRefundInfo"]),
		flightRescheduleInfo: FlightRescheduleInfo.fromJson(json["flightRescheduleInfo"]),
		routeInventories: List<RouteInventory>.from(json["routeInventories"].map((x) => RouteInventory.fromJson(x))),
		promoLabels: List<dynamic>.from(json["promoLabels"].map((x) => x)),
		loyaltyPoint: json["loyaltyPoint"],
	);
	
	Map<String, dynamic> toJson() => {
		"departureAirport": departureAirport,
		"arrivalAirport": arrivalAirport,
		"providerId": providerId,
		"dateTimeStamp": dateTimeStamp,
		"numDayOffset": numDayOffset,
		"totalNumStop": totalNumStop,
		"flightRefundInfo": flightRefundInfo.toJson(),
		"flightRescheduleInfo": flightRescheduleInfo.toJson(),
		"routeInventories": List<dynamic>.from(routeInventories.map((x) => x.toJson())),
		"segments": List<dynamic>.from(segments.map((x) => x.toJson())),
		"promoLabels": List<dynamic>.from(promoLabels.map((x) => x)),
		"loyaltyPoint": loyaltyPoint,
	};
}

class FlightRefundInfo {
	String refundableStatus;
	String refundInfoSummary;
	List<dynamic> policyDetails;
	
	FlightRefundInfo({
		this.refundableStatus,
		this.refundInfoSummary,
		this.policyDetails,
	});
	
	factory FlightRefundInfo.fromJson(Map<String, dynamic> json) => FlightRefundInfo(
		refundableStatus: json["refundableStatus"],
		refundInfoSummary: json["refundInfoSummary"] == null ? null : json["refundInfoSummary"],
		policyDetails: List<dynamic>.from(json["policyDetails"].map((x) => x)),
	);
	
	Map<String, dynamic> toJson() => {
		"refundableStatus": refundableStatus,
		"refundInfoSummary": refundInfoSummary == null ? null : refundInfoSummary,
		"policyDetails": List<dynamic>.from(policyDetails.map((x) => x)),
	};
}



class FlightRescheduleInfo {
	String rescheduleStatus;
	dynamic rescheduleInfoSummary;
	List<dynamic> policyDetails;
	
	FlightRescheduleInfo({
		this.rescheduleStatus,
		this.rescheduleInfoSummary,
		this.policyDetails,
	});
	
	factory FlightRescheduleInfo.fromJson(Map<String, dynamic> json) => FlightRescheduleInfo(
		rescheduleStatus: json["rescheduleStatus"],
		rescheduleInfoSummary: json["rescheduleInfoSummary"],
		policyDetails: List<dynamic>.from(json["policyDetails"].map((x) => x)),
	);
	
	Map<String, dynamic> toJson() => {
		"rescheduleStatus": rescheduleStatus,
		"rescheduleInfoSummary": rescheduleInfoSummary,
		"policyDetails": List<dynamic>.from(policyDetails.map((x) => x)),
	};
}



class RouteInventory {
	String seatPublishedClass;
	dynamic seatClass;
	String numSeatLeft;
	
	RouteInventory({
		this.seatPublishedClass,
		this.seatClass,
		this.numSeatLeft,
	});
	
	factory RouteInventory.fromJson(Map<String, dynamic> json) => RouteInventory(
		seatPublishedClass: json["seatPublishedClass"],
		seatClass: json["seatClass"],
		numSeatLeft: json["numSeatLeft"],
	);
	
	Map<String, dynamic> toJson() => {
		"seatPublishedClass": seatPublishedClass,
		"seatClass": seatClass,
		"numSeatLeft": numSeatLeft,
	};
}


class Segment {
	String departureAirport;
	String arrivalAirport;
	String flightNumber;
	String airlineCode;
	String brandCode;
	String operatingAirlineCode;
	String fareBasisCode;
	List<SegmentInventory> segmentInventories;
	dynamic aircraftType;
	bool hasMeal;
	FreeBaggageInfo freeBaggageInfo;
	Facilities facilities;
	AircraftInformation aircraftInformation;
	List<dynamic> flightLegInfoList;
	String numTransit;
	String durationMinute;
	String routeNumDaysOffset;
	String tzDepartureMinuteOffset;
	String tzArrivalMinuteOffset;
	Date departureDate;
	Date arrivalDate;
	Time departureTime;
	Time arrivalTime;
	bool visaRequired;
	bool mayReCheckIn;
	
	Segment({
		this.departureAirport,
		this.arrivalAirport,
		this.flightNumber,
		this.airlineCode,
		this.brandCode,
		this.operatingAirlineCode,
		this.fareBasisCode,
		this.segmentInventories,
		this.aircraftType,
		this.hasMeal,
		this.freeBaggageInfo,
		this.facilities,
		this.aircraftInformation,
		this.flightLegInfoList,
		this.numTransit,
		this.durationMinute,
		this.routeNumDaysOffset,
		this.tzDepartureMinuteOffset,
		this.tzArrivalMinuteOffset,
		this.departureDate,
		this.arrivalDate,
		this.departureTime,
		this.arrivalTime,
		this.visaRequired,
		this.mayReCheckIn,
	});
	
	factory Segment.fromJson(Map<String, dynamic> json) => Segment(
		departureAirport: json["departureAirport"],
		arrivalAirport: json["arrivalAirport"],
		flightNumber: json["flightNumber"],
		airlineCode: json["airlineCode"],
		brandCode: json["brandCode"],
		operatingAirlineCode: json["operatingAirlineCode"] == null ? null : json["operatingAirlineCode"],
		fareBasisCode: json["fareBasisCode"] == null ? null : json["fareBasisCode"],
		segmentInventories: List<SegmentInventory>.from(json["segmentInventories"].map((x) => SegmentInventory.fromJson(x))),
		aircraftType: json["aircraftType"],
		hasMeal: json["hasMeal"],
		freeBaggageInfo: FreeBaggageInfo.fromJson(json["freeBaggageInfo"]),
		facilities: Facilities.fromJson(json["facilities"]),
		flightLegInfoList: List<dynamic>.from(json["flightLegInfoList"].map((x) => x)),
		numTransit: json["numTransit"],
		durationMinute: json["durationMinute"],
		routeNumDaysOffset: json["routeNumDaysOffset"],
		tzDepartureMinuteOffset: json["tzDepartureMinuteOffset"],
		tzArrivalMinuteOffset: json["tzArrivalMinuteOffset"],
		departureDate: Date.fromJson(json["departureDate"]),
		arrivalDate: Date.fromJson(json["arrivalDate"]),
		departureTime: Time.fromJson(json["departureTime"]),
		arrivalTime: Time.fromJson(json["arrivalTime"]),
		visaRequired: json["visaRequired"],
		mayReCheckIn: json["mayReCheckIn"],
	);
	
	Map<String, dynamic> toJson() => {
		"departureAirport": departureAirport,
		"arrivalAirport": arrivalAirport,
		"flightNumber": flightNumber,
		"airlineCode": airlineCode,
		"brandCode": brandCode,
		"operatingAirlineCode": operatingAirlineCode == null ? null : operatingAirlineCode,
		"fareBasisCode": fareBasisCode == null ? null : fareBasisCode,
		"segmentInventories": List<dynamic>.from(segmentInventories.map((x) => x.toJson())),
		"aircraftType": aircraftType,
		"hasMeal": hasMeal,
		"freeBaggageInfo": freeBaggageInfo.toJson(),
		"facilities": facilities.toJson(),
		"aircraftInformation": aircraftInformation.toJson(),
		"flightLegInfoList": List<dynamic>.from(flightLegInfoList.map((x) => x)),
		"numTransit": numTransit,
		"durationMinute": durationMinute,
		"routeNumDaysOffset": routeNumDaysOffset,
		"tzDepartureMinuteOffset": tzDepartureMinuteOffset,
		"tzArrivalMinuteOffset": tzArrivalMinuteOffset,
		"departureDate": departureDate.toJson(),
		"arrivalDate": arrivalDate.toJson(),
		"departureTime": departureTime.toJson(),
		"arrivalTime": arrivalTime.toJson(),
		"visaRequired": visaRequired,
		"mayReCheckIn": mayReCheckIn,
	};
}

class AircraftInformation {
	Aircraft aircraft;
	FreeBaggageInfo cabinBaggage;
	
	AircraftInformation({
		this.aircraft,
		this.cabinBaggage,
	});
	
	factory AircraftInformation.fromJson(Map<String, dynamic> json) => AircraftInformation(
		aircraft: json["aircraft"] == null ? null : Aircraft.fromJson(json["aircraft"]),
		cabinBaggage: json["cabinBaggage"] == null ? null : FreeBaggageInfo.fromJson(json["cabinBaggage"]),
	);
	
	Map<String, dynamic> toJson() => {
		"aircraft": aircraft == null ? null : aircraft.toJson(),
		"cabinBaggage": cabinBaggage == null ? null : cabinBaggage.toJson(),
	};
}

class Aircraft {
	String model;
	dynamic type;
	SeatInformation seatInformation;
	
	Aircraft({
		this.model,
		this.type,
		this.seatInformation,
	});
	
	factory Aircraft.fromJson(Map<String, dynamic> json) => Aircraft(
		model: json["model"] == null ? null : json["model"],
		type: json["type"],
	);
	
	Map<String, dynamic> toJson() => {
		"model": model == null ? null : model,
		"type": type,
		"seatInformation": seatInformation.toJson(),
	};
}


class SeatInformation {
	String layout;
	String pitch;
	Type type;
	
	SeatInformation({
		this.layout,
		this.pitch,
		this.type,
	});
	
	factory SeatInformation.fromJson(Map<String, dynamic> json) => SeatInformation(
		layout: json["layout"] == null ? null : json["layout"],
		pitch: json["pitch"] == null ? null : json["pitch"],
	);
	
	Map<String, dynamic> toJson() => {
		"layout": layout == null ? null : layout,
		"pitch": pitch == null ? null : pitch,
		"type": type == null ? null : type,
	};
}




class FreeBaggageInfo {
	String unitOfMeasure;
	String weight;
	String quantity;
	bool availableToBuy;
	
	FreeBaggageInfo({
		this.unitOfMeasure,
		this.weight,
		this.quantity,
		this.availableToBuy,
	});
	
	factory FreeBaggageInfo.fromJson(Map<String, dynamic> json) => FreeBaggageInfo(
		unitOfMeasure: json["unitOfMeasure"],
		weight: json["weight"],
		quantity: json["quantity"],
		availableToBuy: json["availableToBuy"] == null ? null : json["availableToBuy"],
	);
	
	Map<String, dynamic> toJson() => {
		"unitOfMeasure": unitOfMeasure,
		"weight": weight,
		"quantity": quantity,
		"availableToBuy": availableToBuy == null ? null : availableToBuy,
	};
}



class Date {
	String month;
	String day;
	String year;
	
	Date({
		this.month,
		this.day,
		this.year,
	});
	
	factory Date.fromJson(Map<String, dynamic> json) => Date(
		month: json["month"],
		day: json["day"],
		year: json["year"],
	);
	
	Map<String, dynamic> toJson() => {
		"month": month,
		"day": day,
		"year": year,
	};
}

class Time {
	String hour;
	String minute;
	
	Time({
		this.hour,
		this.minute,
	});
	
	factory Time.fromJson(Map<String, dynamic> json) => Time(
		hour: json["hour"],
		minute: json["minute"],
	);
	
	Map<String, dynamic> toJson() => {
		"hour": hour,
		"minute": minute,
	};
}

class Facilities {
	FreeBaggageInfo baggage;
	Wifi wifi;
	Entertainment freeMeal;
	Entertainment entertainment;
	UsbAndPower usbAndPower;
	List<String> order;
	
	Facilities({
		this.baggage,
		this.wifi,
		this.freeMeal,
		this.entertainment,
		this.usbAndPower,
		this.order,
	});
	
	factory Facilities.fromJson(Map<String, dynamic> json) => Facilities(
		baggage: FreeBaggageInfo.fromJson(json["baggage"]),
		wifi: Wifi.fromJson(json["wifi"]),
		freeMeal: Entertainment.fromJson(json["freeMeal"]),
		entertainment: Entertainment.fromJson(json["entertainment"]),
		usbAndPower: UsbAndPower.fromJson(json["usbAndPower"]),
	);
	
	Map<String, dynamic> toJson() => {
		"baggage": baggage.toJson(),
		"wifi": wifi.toJson(),
		"freeMeal": freeMeal.toJson(),
		"entertainment": entertainment.toJson(),
		"usbAndPower": usbAndPower.toJson(),
	};
}

class Entertainment {
	bool available;
	
	Entertainment({
		this.available,
	});
	
	factory Entertainment.fromJson(Map<String, dynamic> json) => Entertainment(
		available: json["available"],
	);
	
	Map<String, dynamic> toJson() => {
		"available": available,
	};
}



class UsbAndPower {
	bool usb;
	bool power;
	String chance;
	
	UsbAndPower({
		this.usb,
		this.power,
		this.chance,
	});
	
	factory UsbAndPower.fromJson(Map<String, dynamic> json) => UsbAndPower(
		usb: json["usb"],
		power: json["power"],
		chance: json["chance"],
	);
	
	Map<String, dynamic> toJson() => {
		"usb": usb,
		"power": power,
		"chance": chance,
	};
}


class Wifi {
	String cost;
	String chance;
	
	Wifi({
		this.cost,
		this.chance,
	});
	
	factory Wifi.fromJson(Map<String, dynamic> json) => Wifi(
		cost: json["cost"],
		chance: json["chance"],
	);
	
	Map<String, dynamic> toJson() => {
		"cost": cost,
		"chance": chance,
	};
}



class SegmentInventory {
	dynamic seatClass;
	dynamic numSeatsLeft;
	String publishedClass;
	dynamic fareBasis;
	String refundable;
	dynamic subclassInfo;
	
	SegmentInventory({
		this.seatClass,
		this.numSeatsLeft,
		this.publishedClass,
		this.fareBasis,
		this.refundable,
		this.subclassInfo,
	});
	
	factory SegmentInventory.fromJson(Map<String, dynamic> json) => SegmentInventory(
		seatClass: json["seatClass"],
		numSeatsLeft: json["numSeatsLeft"],
		publishedClass: json["publishedClass"],
		fareBasis: json["fareBasis"],
		refundable: json["refundable"],
		subclassInfo: json["subclassInfo"],
	);
	
	Map<String, dynamic> toJson() => {
		"seatClass": seatClass,
		"numSeatsLeft": numSeatsLeft,
		"publishedClass": publishedClass,
		"fareBasis": fareBasis,
		"refundable": refundable,
		"subclassInfo": subclassInfo,
	};
}

class FlightMetadatum {
	String currency;
	String airlineId;
	String sourceAirport;
	String destinationAirport;
	String numAdult;
	String numChild;
	String numInfant;
	
	FlightMetadatum({
		this.currency,
		this.airlineId,
		this.sourceAirport,
		this.destinationAirport,
		this.numAdult,
		this.numChild,
		this.numInfant,
	});
	
	factory FlightMetadatum.fromJson(Map<String, dynamic> json) => FlightMetadatum(
		currency: json["currency"],
		airlineId: json["airlineId"],
		sourceAirport: json["sourceAirport"],
		destinationAirport: json["destinationAirport"],
		numAdult: json["numAdult"],
		numChild: json["numChild"],
		numInfant: json["numInfant"],
	);
	
	Map<String, dynamic> toJson() => {
		"currency": currency,
		"airlineId": airlineId,
		"sourceAirport": sourceAirport,
		"destinationAirport": destinationAirport,
		"numAdult": numAdult,
		"numChild": numChild,
		"numInfant": numInfant,
	};
}

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

class DataFlight2 {
	FlightOneWayModel flightModel;
	Map b1;
	Map airportDataMap;
	
	DataFlight2({this.flightModel, this.b1, this.airportDataMap});
}