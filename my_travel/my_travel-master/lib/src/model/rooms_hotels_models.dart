// To parse this JSON data, do
//
//     final roomsHotelsModels = roomsHotelsModelsFromJson(jsonString);

import 'dart:convert';

RoomsHotelsModels roomsHotelsModelsFromJson(String str) => RoomsHotelsModels.fromJson(json.decode(str));

String roomsHotelsModelsToJson(RoomsHotelsModels data) => json.encode(data.toJson());

class RoomsHotelsModels {
	Data data;
	dynamic userContext;
	
	RoomsHotelsModels({
		this.data,
		this.userContext,
	});
	
	factory RoomsHotelsModels.fromJson(Map<String, dynamic> json) => RoomsHotelsModels(
		data: Data.fromJson(json["data"]),
		userContext: json["userContext"],
	);
	
	Map<String, dynamic> toJson() => {
		"data": data.toJson(),
		"userContext": userContext,
	};
}

class Data {
	String status;
	dynamic message;
	List<RecommendedEntry> recommendedEntries;
	dynamic roomRecommendations;
	String searchId;
	String pricingRuleDescription;
	RoomDisplayInfo roomDisplayInfo;
	bool isReschedule;
	bool isInventoryContainPayAtHotel;
	VariantContexts variantContexts;
	Layout layout;
	String bookmarkInventoryId;
	dynamic userTagContext;
	dynamic worryFreeNotificationText;
	dynamic failedStatusReason;
	bool showResponseAfterLogin;
	dynamic communicationBanner;
	List<AvailableInventoryTag> availableInventoryTags;
	RoomListBanners roomListBanners;
	DataContexts contexts;
	bool reschedule;
	bool inventoryContainPayAtHotel;
	
	Data({
		this.status,
		this.message,
		this.recommendedEntries,
		this.roomRecommendations,
		this.searchId,
		this.pricingRuleDescription,
		this.roomDisplayInfo,
		this.isReschedule,
		this.isInventoryContainPayAtHotel,
		this.variantContexts,
		this.layout,
		this.bookmarkInventoryId,
		this.userTagContext,
		this.worryFreeNotificationText,
		this.failedStatusReason,
		this.showResponseAfterLogin,
		this.communicationBanner,
		this.availableInventoryTags,
		this.roomListBanners,
		this.contexts,
		this.reschedule,
		this.inventoryContainPayAtHotel,
	});
	
	factory Data.fromJson(Map<String, dynamic> json) => Data(
		status: json["status"],
		message: json["message"],
		recommendedEntries: List<RecommendedEntry>.from(json["recommendedEntries"].map((x) => RecommendedEntry.fromJson(x))),
		roomRecommendations: json["roomRecommendations"],
		searchId: json["searchId"],
		pricingRuleDescription: json["pricingRuleDescription"],
		roomDisplayInfo: RoomDisplayInfo.fromJson(json["roomDisplayInfo"]),
		isReschedule: json["isReschedule"],
		isInventoryContainPayAtHotel: json["isInventoryContainPayAtHotel"],
		variantContexts: VariantContexts.fromJson(json["variantContexts"]),
		layout: Layout.fromJson(json["layout"]),
		bookmarkInventoryId: json["bookmarkInventoryId"],
		userTagContext: json["userTagContext"],
		worryFreeNotificationText: json["worryFreeNotificationText"],
		failedStatusReason: json["failedStatusReason"],
		showResponseAfterLogin: json["showResponseAfterLogin"],
		communicationBanner: json["communicationBanner"],
		availableInventoryTags: List<AvailableInventoryTag>.from(json["availableInventoryTags"].map((x) => AvailableInventoryTag.fromJson(x))),
		roomListBanners: RoomListBanners.fromJson(json["roomListBanners"]),
		contexts: DataContexts.fromJson(json["contexts"]),
		reschedule: json["reschedule"],
		inventoryContainPayAtHotel: json["inventoryContainPayAtHotel"],
	);
	
	Map<String, dynamic> toJson() => {
		"status": status,
		"message": message,
		"recommendedEntries": List<dynamic>.from(recommendedEntries.map((x) => x.toJson())),
		"roomRecommendations": roomRecommendations,
		"searchId": searchId,
		"pricingRuleDescription": pricingRuleDescription,
		"roomDisplayInfo": roomDisplayInfo.toJson(),
		"isReschedule": isReschedule,
		"isInventoryContainPayAtHotel": isInventoryContainPayAtHotel,
		"variantContexts": variantContexts.toJson(),
		"layout": layout.toJson(),
		"bookmarkInventoryId": bookmarkInventoryId,
		"userTagContext": userTagContext,
		"worryFreeNotificationText": worryFreeNotificationText,
		"failedStatusReason": failedStatusReason,
		"showResponseAfterLogin": showResponseAfterLogin,
		"communicationBanner": communicationBanner,
		"availableInventoryTags": List<dynamic>.from(availableInventoryTags.map((x) => x.toJson())),
		"roomListBanners": roomListBanners.toJson(),
		"contexts": contexts.toJson(),
		"reschedule": reschedule,
		"inventoryContainPayAtHotel": inventoryContainPayAtHotel,
	};
}

class AvailableInventoryTag {
	Name name;
	String displayName;
	String description;
	String shortDescription;
	
	AvailableInventoryTag({
		this.name,
		this.displayName,
		this.description,
		this.shortDescription,
	});
	
	factory AvailableInventoryTag.fromJson(Map<String, dynamic> json) => AvailableInventoryTag(
		name: nameValues.map[json["name"]],
		displayName: json["displayName"],
		description: json["description"],
		shortDescription: json["shortDescription"],
	);
	
	Map<String, dynamic> toJson() => {
		"name": nameValues.reverse[name],
		"displayName": displayName,
		"description": description,
		"shortDescription": shortDescription,
	};
}

enum Name { FREE_CANCELLATION, FREE_BREAKFAST, LARGE_BED }

final nameValues = EnumValues({
	"FREE_BREAKFAST": Name.FREE_BREAKFAST,
	"FREE_CANCELLATION": Name.FREE_CANCELLATION,
	"LARGE_BED": Name.LARGE_BED
});

class DataContexts {
	dynamic metasearchToken;
	dynamic encryptedAccessCode;
	
	DataContexts({
		this.metasearchToken,
		this.encryptedAccessCode,
	});
	
	factory DataContexts.fromJson(Map<String, dynamic> json) => DataContexts(
		metasearchToken: json["metasearchToken"],
		encryptedAccessCode: json["encryptedAccessCode"],
	);
	
	Map<String, dynamic> toJson() => {
		"metasearchToken": metasearchToken,
		"encryptedAccessCode": encryptedAccessCode,
	};
}

class Layout {
	String detail;
	String card;
	bool useNewRoomMappingLayout;
	
	Layout({
		this.detail,
		this.card,
		this.useNewRoomMappingLayout,
	});
	
	factory Layout.fromJson(Map<String, dynamic> json) => Layout(
		detail: json["detail"],
		card: json["card"],
		useNewRoomMappingLayout: json["useNewRoomMappingLayout"],
	);
	
	Map<String, dynamic> toJson() => {
		"detail": detail,
		"card": card,
		"useNewRoomMappingLayout": useNewRoomMappingLayout,
	};
}

class RecommendedEntry {
	List<RoomList> roomList;
	
	RecommendedEntry({
		this.roomList,
	});
	
	factory RecommendedEntry.fromJson(Map<String, dynamic> json) => RecommendedEntry(
		roomList: List<RoomList>.from(json["roomList"].map((x) => RoomList.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"roomList": List<dynamic>.from(roomList.map((x) => x.toJson())),
	};
}

class RoomList {
	String hotelRoomId;
	String providerId;
	String name;
	List<String> roomImages;
	String description;
	String originalDescription;
	BedDescription bedDescription;
	String maxOccupancy;
	String baseOccupancy;
	String maxChildOccupancy;
	String maxChildAge;
	String numExtraBeds;
	String numChargedRooms;
	String numRemainingRooms;
	String numBreakfastIncluded;
	bool isBreakfastIncluded;
	bool isWifiIncluded;
	bool isRefundable;
	bool hasLivingRoom;
	bool extraBedIsIncluded;
	dynamic size;
	RateDisplay rateDisplay;
	RateDisplay originalRateDisplay;
	RateDisplay strikethroughRateDisplay;
	dynamic propertyCurrencyRateDisplay;
	dynamic propertyCurrencyOriginalRateDisplay;
	dynamic rescheduleRateDisplay;
	dynamic isCashback;
	RateInfo rateInfo;
	dynamic extraBedRate;
	dynamic vatInvoice;
	RoomCancellationPolicy roomCancellationPolicy;
	dynamic roomReschedulePolicy;
	dynamic extraBedSummaries;
	bool promoFlag;
	RoomListContexts contexts;
	List<dynamic> amenitiesExcluded;
	List<String> amenitiesIncluded;
	AmenitiesByCategory amenitiesByCategory;
	List<dynamic> roomHighlightFacilityDisplay;
	dynamic promoIds;
	HotelPromoType hotelPromoType;
	LabelDisplayData labelDisplayData;
	List<BedroomSummary> hotelBedType;
	BedArrangements bedArrangements;
	dynamic hotelRoomSizeDisplay;
	String hotelRoomType;
	dynamic smokingPreferences;
	RateType rateType;
	dynamic ccGuaranteeRequirement;
	dynamic additionalCharges;
	dynamic propertyCurrencyAdditionalCharges;
	String loyaltyAmount;
	HotelLoyaltyDisplay hotelLoyaltyDisplay;
	AccomLoyaltyEligibilityStatus accomLoyaltyEligibilityStatus;
	dynamic checkInInstruction;
	dynamic walletPromoDisplay;
	List<ImageWithCaption> imageWithCaptions;
	String caption;
	String inventoryName;
	List<Name> inventoryTags;
	ExtraBedSearchSummary extraBedSearchSummary;
	dynamic extraBedRateSummary;
	ChildOccupancyPolicyDisplay childOccupancyPolicyDisplay;
	dynamic disabilitySupport;
	dynamic bookingPolicy;
	bool isBookable;
	dynamic inventoryLabelDisplay;
	dynamic supportedAddOns;
	InventoryLabels inventoryLabels;
	dynamic cashback;
	bool breakfastIncluded;
	bool wifiIncluded;
	bool refundable;
	
	RoomList({
		this.hotelRoomId,
		this.providerId,
		this.name,
		this.roomImages,
		this.description,
		this.originalDescription,
		this.bedDescription,
		this.maxOccupancy,
		this.baseOccupancy,
		this.maxChildOccupancy,
		this.maxChildAge,
		this.numExtraBeds,
		this.numChargedRooms,
		this.numRemainingRooms,
		this.numBreakfastIncluded,
		this.isBreakfastIncluded,
		this.isWifiIncluded,
		this.isRefundable,
		this.hasLivingRoom,
		this.extraBedIsIncluded,
		this.size,
		this.rateDisplay,
		this.originalRateDisplay,
		this.strikethroughRateDisplay,
		this.propertyCurrencyRateDisplay,
		this.propertyCurrencyOriginalRateDisplay,
		this.rescheduleRateDisplay,
		this.isCashback,
		this.rateInfo,
		this.extraBedRate,
		this.vatInvoice,
		this.roomCancellationPolicy,
		this.roomReschedulePolicy,
		this.extraBedSummaries,
		this.promoFlag,
		this.contexts,
		this.amenitiesExcluded,
		this.amenitiesIncluded,
		this.amenitiesByCategory,
		this.roomHighlightFacilityDisplay,
		this.promoIds,
		this.hotelPromoType,
		this.labelDisplayData,
		this.hotelBedType,
		this.bedArrangements,
		this.hotelRoomSizeDisplay,
		this.hotelRoomType,
		this.smokingPreferences,
		this.rateType,
		this.ccGuaranteeRequirement,
		this.additionalCharges,
		this.propertyCurrencyAdditionalCharges,
		this.loyaltyAmount,
		this.hotelLoyaltyDisplay,
		this.accomLoyaltyEligibilityStatus,
		this.checkInInstruction,
		this.walletPromoDisplay,
		this.imageWithCaptions,
		this.caption,
		this.inventoryName,
		this.inventoryTags,
		this.extraBedSearchSummary,
		this.extraBedRateSummary,
		this.childOccupancyPolicyDisplay,
		this.disabilitySupport,
		this.bookingPolicy,
		this.isBookable,
		this.inventoryLabelDisplay,
		this.supportedAddOns,
		this.inventoryLabels,
		this.cashback,
		this.breakfastIncluded,
		this.wifiIncluded,
		this.refundable,
	});
	
	factory RoomList.fromJson(Map<String, dynamic> json) => RoomList(
		hotelRoomId: json["hotelRoomId"],
		providerId: json["providerId"],
		name: json["name"],
		roomImages: List<String>.from(json["roomImages"].map((x) => x)),
		description: json["description"],
		originalDescription: json["originalDescription"],
		bedDescription: bedDescriptionValues.map[json["bedDescription"]],
		maxOccupancy: json["maxOccupancy"],
		baseOccupancy: json["baseOccupancy"],
		maxChildOccupancy: json["maxChildOccupancy"],
		maxChildAge: json["maxChildAge"],
		numExtraBeds: json["numExtraBeds"],
		numChargedRooms: json["numChargedRooms"],
		numRemainingRooms: json["numRemainingRooms"],
		numBreakfastIncluded: json["numBreakfastIncluded"],
		isBreakfastIncluded: json["isBreakfastIncluded"],
		isWifiIncluded: json["isWifiIncluded"],
		isRefundable: json["isRefundable"],
		hasLivingRoom: json["hasLivingRoom"],
		extraBedIsIncluded: json["extraBedIsIncluded"],
		size: json["size"],
		rateDisplay: RateDisplay.fromJson(json["rateDisplay"]),
		originalRateDisplay: RateDisplay.fromJson(json["originalRateDisplay"]),
		strikethroughRateDisplay: RateDisplay.fromJson(json["strikethroughRateDisplay"]),
		propertyCurrencyRateDisplay: json["propertyCurrencyRateDisplay"],
		propertyCurrencyOriginalRateDisplay: json["propertyCurrencyOriginalRateDisplay"],
		rescheduleRateDisplay: json["rescheduleRateDisplay"],
		isCashback: json["isCashback"],
		rateInfo: RateInfo.fromJson(json["rateInfo"]),
		extraBedRate: json["extraBedRate"],
		vatInvoice: json["vatInvoice"],
		roomCancellationPolicy: RoomCancellationPolicy.fromJson(json["roomCancellationPolicy"]),
		roomReschedulePolicy: json["roomReschedulePolicy"],
		extraBedSummaries: json["extraBedSummaries"],
		promoFlag: json["promoFlag"],
		contexts: RoomListContexts.fromJson(json["contexts"]),
		amenitiesExcluded: List<dynamic>.from(json["amenitiesExcluded"].map((x) => x)),
		amenitiesIncluded: List<String>.from(json["amenitiesIncluded"].map((x) => x)),
		amenitiesByCategory: AmenitiesByCategory.fromJson(json["amenitiesByCategory"]),
		roomHighlightFacilityDisplay: List<dynamic>.from(json["roomHighlightFacilityDisplay"].map((x) => x)),
		promoIds: json["promoIds"],
		hotelPromoType: HotelPromoType.fromJson(json["hotelPromoType"]),
		labelDisplayData: json["labelDisplayData"] == null ? null : LabelDisplayData.fromJson(json["labelDisplayData"]),
		hotelBedType: List<BedroomSummary>.from(json["hotelBedType"].map((x) => bedroomSummaryValues.map[x])),
		bedArrangements: BedArrangements.fromJson(json["bedArrangements"]),
		hotelRoomSizeDisplay: json["hotelRoomSizeDisplay"],
		hotelRoomType: json["hotelRoomType"],
		smokingPreferences: json["smokingPreferences"],
		rateType: rateTypeValues.map[json["rateType"]],
		ccGuaranteeRequirement: json["ccGuaranteeRequirement"],
		additionalCharges: json["additionalCharges"],
		propertyCurrencyAdditionalCharges: json["propertyCurrencyAdditionalCharges"],
		loyaltyAmount: json["loyaltyAmount"],
		hotelLoyaltyDisplay: HotelLoyaltyDisplay.fromJson(json["hotelLoyaltyDisplay"]),
		accomLoyaltyEligibilityStatus: accomLoyaltyEligibilityStatusValues.map[json["accomLoyaltyEligibilityStatus"]],
		checkInInstruction: json["checkInInstruction"],
		walletPromoDisplay: json["walletPromoDisplay"],
		imageWithCaptions: List<ImageWithCaption>.from(json["imageWithCaptions"].map((x) => ImageWithCaption.fromJson(x))),
		caption: json["caption"],
		inventoryName: json["inventoryName"],
		inventoryTags: List<Name>.from(json["inventoryTags"].map((x) => nameValues.map[x])),
		extraBedSearchSummary: ExtraBedSearchSummary.fromJson(json["extraBedSearchSummary"]),
		extraBedRateSummary: json["extraBedRateSummary"],
		childOccupancyPolicyDisplay: ChildOccupancyPolicyDisplay.fromJson(json["childOccupancyPolicyDisplay"]),
		disabilitySupport: json["disabilitySupport"],
		bookingPolicy: json["bookingPolicy"],
		isBookable: json["isBookable"],
		inventoryLabelDisplay: json["inventoryLabelDisplay"],
		supportedAddOns: json["supportedAddOns"],
		inventoryLabels: json["inventoryLabels"] == null ? null : InventoryLabels.fromJson(json["inventoryLabels"]),
		cashback: json["cashback"],
		breakfastIncluded: json["breakfastIncluded"],
		wifiIncluded: json["wifiIncluded"],
		refundable: json["refundable"],
	);
	
	Map<String, dynamic> toJson() => {
		"hotelRoomId": hotelRoomId,
		"providerId": providerId,
		"name": name,
		"roomImages": List<dynamic>.from(roomImages.map((x) => x)),
		"description": description,
		"originalDescription": originalDescription,
		"bedDescription": bedDescriptionValues.reverse[bedDescription],
		"maxOccupancy": maxOccupancy,
		"baseOccupancy": baseOccupancy,
		"maxChildOccupancy": maxChildOccupancy,
		"maxChildAge": maxChildAge,
		"numExtraBeds": numExtraBeds,
		"numChargedRooms": numChargedRooms,
		"numRemainingRooms": numRemainingRooms,
		"numBreakfastIncluded": numBreakfastIncluded,
		"isBreakfastIncluded": isBreakfastIncluded,
		"isWifiIncluded": isWifiIncluded,
		"isRefundable": isRefundable,
		"hasLivingRoom": hasLivingRoom,
		"extraBedIsIncluded": extraBedIsIncluded,
		"size": size,
		"rateDisplay": rateDisplay.toJson(),
		"originalRateDisplay": originalRateDisplay.toJson(),
		"strikethroughRateDisplay": strikethroughRateDisplay.toJson(),
		"propertyCurrencyRateDisplay": propertyCurrencyRateDisplay,
		"propertyCurrencyOriginalRateDisplay": propertyCurrencyOriginalRateDisplay,
		"rescheduleRateDisplay": rescheduleRateDisplay,
		"isCashback": isCashback,
		"rateInfo": rateInfo.toJson(),
		"extraBedRate": extraBedRate,
		"vatInvoice": vatInvoice,
		"roomCancellationPolicy": roomCancellationPolicy.toJson(),
		"roomReschedulePolicy": roomReschedulePolicy,
		"extraBedSummaries": extraBedSummaries,
		"promoFlag": promoFlag,
		"contexts": contexts.toJson(),
		"amenitiesExcluded": List<dynamic>.from(amenitiesExcluded.map((x) => x)),
		"amenitiesIncluded": List<dynamic>.from(amenitiesIncluded.map((x) => x)),
		"amenitiesByCategory": amenitiesByCategory.toJson(),
		"roomHighlightFacilityDisplay": List<dynamic>.from(roomHighlightFacilityDisplay.map((x) => x)),
		"promoIds": promoIds,
		"hotelPromoType": hotelPromoType.toJson(),
		"labelDisplayData": labelDisplayData == null ? null : labelDisplayData.toJson(),
		"hotelBedType": List<dynamic>.from(hotelBedType.map((x) => bedroomSummaryValues.reverse[x])),
		"bedArrangements": bedArrangements.toJson(),
		"hotelRoomSizeDisplay": hotelRoomSizeDisplay,
		"hotelRoomType": hotelRoomType,
		"smokingPreferences": smokingPreferences,
		"rateType": rateTypeValues.reverse[rateType],
		"ccGuaranteeRequirement": ccGuaranteeRequirement,
		"additionalCharges": additionalCharges,
		"propertyCurrencyAdditionalCharges": propertyCurrencyAdditionalCharges,
		"loyaltyAmount": loyaltyAmount,
		"hotelLoyaltyDisplay": hotelLoyaltyDisplay.toJson(),
		"accomLoyaltyEligibilityStatus": accomLoyaltyEligibilityStatusValues.reverse[accomLoyaltyEligibilityStatus],
		"checkInInstruction": checkInInstruction,
		"walletPromoDisplay": walletPromoDisplay,
		"imageWithCaptions": List<dynamic>.from(imageWithCaptions.map((x) => x.toJson())),
		"caption": caption,
		"inventoryName": inventoryName,
		"inventoryTags": List<dynamic>.from(inventoryTags.map((x) => nameValues.reverse[x])),
		"extraBedSearchSummary": extraBedSearchSummary.toJson(),
		"extraBedRateSummary": extraBedRateSummary,
		"childOccupancyPolicyDisplay": childOccupancyPolicyDisplay.toJson(),
		"disabilitySupport": disabilitySupport,
		"bookingPolicy": bookingPolicy,
		"isBookable": isBookable,
		"inventoryLabelDisplay": inventoryLabelDisplay,
		"supportedAddOns": supportedAddOns,
		"inventoryLabels": inventoryLabels == null ? null : inventoryLabels.toJson(),
		"cashback": cashback,
		"breakfastIncluded": breakfastIncluded,
		"wifiIncluded": wifiIncluded,
		"refundable": refundable,
	};
}

enum AccomLoyaltyEligibilityStatus { USER_NOT_ELIGIBLE }

final accomLoyaltyEligibilityStatusValues = EnumValues({
	"USER_NOT_ELIGIBLE": AccomLoyaltyEligibilityStatus.USER_NOT_ELIGIBLE
});

class AmenitiesByCategory {
	List<Amenity> freebies;
	List<Amenity> amenities;
	List<Amenity> bathroom;
	
	AmenitiesByCategory({
		this.freebies,
		this.amenities,
		this.bathroom,
	});
	
	factory AmenitiesByCategory.fromJson(Map<String, dynamic> json) => AmenitiesByCategory(
		freebies: List<Amenity>.from(json["freebies"].map((x) => Amenity.fromJson(x))),
		amenities: List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x))),
		bathroom: List<Amenity>.from(json["bathroom"].map((x) => Amenity.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"freebies": List<dynamic>.from(freebies.map((x) => x.toJson())),
		"amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
		"bathroom": List<dynamic>.from(bathroom.map((x) => x.toJson())),
	};
}

class Amenity {
	String name;
	String iconUrl;
	
	Amenity({
		this.name,
		this.iconUrl,
	});
	
	factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
		name: json["name"],
		iconUrl: json["iconUrl"],
	);
	
	Map<String, dynamic> toJson() => {
		"name": name,
		"iconUrl": iconUrl,
	};
}

class BedArrangements {
	BedroomSummary bedroomSummary;
	String numOfBedroom;
	List<Bedroom> bedrooms;
	
	BedArrangements({
		this.bedroomSummary,
		this.numOfBedroom,
		this.bedrooms,
	});
	
	factory BedArrangements.fromJson(Map<String, dynamic> json) => BedArrangements(
		bedroomSummary: bedroomSummaryValues.map[json["bedroomSummary"]],
		numOfBedroom: json["numOfBedroom"],
		bedrooms: List<Bedroom>.from(json["bedrooms"].map((x) => Bedroom.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"bedroomSummary": bedroomSummaryValues.reverse[bedroomSummary],
		"numOfBedroom": numOfBedroom,
		"bedrooms": List<dynamic>.from(bedrooms.map((x) => x.toJson())),
	};
}

enum BedroomSummary { THE_1_GING_FULL, THE_1_GING_C_KING, THE_2_GING_X_2 }

final bedroomSummaryValues = EnumValues({
	"1 giường cỡ king": BedroomSummary.THE_1_GING_C_KING,
	"1 giường Full": BedroomSummary.THE_1_GING_FULL,
	"2 giường (x 2)": BedroomSummary.THE_2_GING_X_2
});

class Bedroom {
	List<Default> defaultArrangement;
	List<dynamic> alternativeArrangement;
	Arrangements arrangements;
	
	Bedroom({
		this.defaultArrangement,
		this.alternativeArrangement,
		this.arrangements,
	});
	
	factory Bedroom.fromJson(Map<String, dynamic> json) => Bedroom(
		defaultArrangement: List<Default>.from(json["defaultArrangement"].map((x) => Default.fromJson(x))),
		alternativeArrangement: List<dynamic>.from(json["alternativeArrangement"].map((x) => x)),
		arrangements: Arrangements.fromJson(json["arrangements"]),
	);
	
	Map<String, dynamic> toJson() => {
		"defaultArrangement": List<dynamic>.from(defaultArrangement.map((x) => x.toJson())),
		"alternativeArrangement": List<dynamic>.from(alternativeArrangement.map((x) => x)),
		"arrangements": arrangements.toJson(),
	};
}

class Arrangements {
	List<Default> arrangementsDefault;
	
	Arrangements({
		this.arrangementsDefault,
	});
	
	factory Arrangements.fromJson(Map<String, dynamic> json) => Arrangements(
		arrangementsDefault: List<Default>.from(json["default"].map((x) => Default.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"default": List<dynamic>.from(arrangementsDefault.map((x) => x.toJson())),
	};
}

class Default {
	BedName bedName;
	String total;
	String bedIcon;
	
	Default({
		this.bedName,
		this.total,
		this.bedIcon,
	});
	
	factory Default.fromJson(Map<String, dynamic> json) => Default(
		bedName: bedNameValues.map[json["bedName"]],
		total: json["total"],
		bedIcon: json["bedIcon"],
	);
	
	Map<String, dynamic> toJson() => {
		"bedName": bedNameValues.reverse[bedName],
		"total": total,
		"bedIcon": bedIcon,
	};
}

enum BedName { GING_FULL, GING_C_KING, GING_X_2 }

final bedNameValues = EnumValues({
	"giường cỡ king": BedName.GING_C_KING,
	"giường Full": BedName.GING_FULL,
	"giường (x 2)": BedName.GING_X_2
});

enum BedDescription { FULL, KING, TWIN }

final bedDescriptionValues = EnumValues({
	"Full": BedDescription.FULL,
	"King": BedDescription.KING,
	"Twin": BedDescription.TWIN
});

class ChildOccupancyPolicyDisplay {
	ChildPolicyEligibility childPolicyEligibility;
	dynamic shortChildPolicyDisplayString;
	dynamic fullChildPolicyDisplayString;
	
	ChildOccupancyPolicyDisplay({
		this.childPolicyEligibility,
		this.shortChildPolicyDisplayString,
		this.fullChildPolicyDisplayString,
	});
	
	factory ChildOccupancyPolicyDisplay.fromJson(Map<String, dynamic> json) => ChildOccupancyPolicyDisplay(
		childPolicyEligibility: ChildPolicyEligibility.fromJson(json["childPolicyEligibility"]),
		shortChildPolicyDisplayString: json["shortChildPolicyDisplayString"],
		fullChildPolicyDisplayString: json["fullChildPolicyDisplayString"],
	);
	
	Map<String, dynamic> toJson() => {
		"childPolicyEligibility": childPolicyEligibility.toJson(),
		"shortChildPolicyDisplayString": shortChildPolicyDisplayString,
		"fullChildPolicyDisplayString": fullChildPolicyDisplayString,
	};
}

class ChildPolicyEligibility {
	ChildPolicyStatus childPolicyStatus;
	String numberOfEligibleChild;
	
	ChildPolicyEligibility({
		this.childPolicyStatus,
		this.numberOfEligibleChild,
	});
	
	factory ChildPolicyEligibility.fromJson(Map<String, dynamic> json) => ChildPolicyEligibility(
		childPolicyStatus: childPolicyStatusValues.map[json["childPolicyStatus"]],
		numberOfEligibleChild: json["numberOfEligibleChild"],
	);
	
	Map<String, dynamic> toJson() => {
		"childPolicyStatus": childPolicyStatusValues.reverse[childPolicyStatus],
		"numberOfEligibleChild": numberOfEligibleChild,
	};
}

enum ChildPolicyStatus { FREE }

final childPolicyStatusValues = EnumValues({
	"FREE": ChildPolicyStatus.FREE
});

class RoomListContexts {
	String availToken;
	String searchId;
	bool newroomdataavailable;
	String inventoryRateKey;
	String bookingId;
	String numRooms;
	String numAdults;
	String numChildren;
	List<dynamic> childAges;
	String numInfants;
	
	RoomListContexts({
		this.availToken,
		this.searchId,
		this.newroomdataavailable,
		this.inventoryRateKey,
		this.bookingId,
		this.numRooms,
		this.numAdults,
		this.numChildren,
		this.childAges,
		this.numInfants,
	});
	
	factory RoomListContexts.fromJson(Map<String, dynamic> json) => RoomListContexts(
		availToken: json["availToken"],
		searchId: json["searchId"],
		newroomdataavailable: json["NEWROOMDATAAVAILABLE"],
		inventoryRateKey: json["inventoryRateKey"],
		bookingId: json["bookingId"],
		numRooms: json["numRooms"],
		numAdults: json["numAdults"],
		numChildren: json["numChildren"],
		childAges: List<dynamic>.from(json["childAges"].map((x) => x)),
		numInfants: json["numInfants"],
	);
	
	Map<String, dynamic> toJson() => {
		"availToken": availToken,
		"searchId": searchId,
		"NEWROOMDATAAVAILABLE": newroomdataavailable,
		"inventoryRateKey": inventoryRateKey,
		"bookingId": bookingId,
		"numRooms": numRooms,
		"numAdults": numAdults,
		"numChildren": numChildren,
		"childAges": List<dynamic>.from(childAges.map((x) => x)),
		"numInfants": numInfants,
	};
}

class ExtraBedSearchSummary {
	dynamic maxExtraBeds;
	dynamic numExtraBedIncluded;
	dynamic extraBedRateDisplay;
	dynamic propertyCurrencyExtraBedRateDisplay;
	
	ExtraBedSearchSummary({
		this.maxExtraBeds,
		this.numExtraBedIncluded,
		this.extraBedRateDisplay,
		this.propertyCurrencyExtraBedRateDisplay,
	});
	
	factory ExtraBedSearchSummary.fromJson(Map<String, dynamic> json) => ExtraBedSearchSummary(
		maxExtraBeds: json["maxExtraBeds"],
		numExtraBedIncluded: json["numExtraBedIncluded"],
		extraBedRateDisplay: json["extraBedRateDisplay"],
		propertyCurrencyExtraBedRateDisplay: json["propertyCurrencyExtraBedRateDisplay"],
	);
	
	Map<String, dynamic> toJson() => {
		"maxExtraBeds": maxExtraBeds,
		"numExtraBedIncluded": numExtraBedIncluded,
		"extraBedRateDisplay": extraBedRateDisplay,
		"propertyCurrencyExtraBedRateDisplay": propertyCurrencyExtraBedRateDisplay,
	};
}

class HotelLoyaltyDisplay {
	Display display;
	String amount;
	
	HotelLoyaltyDisplay({
		this.display,
		this.amount,
	});
	
	factory HotelLoyaltyDisplay.fromJson(Map<String, dynamic> json) => HotelLoyaltyDisplay(
		display: displayValues.map[json["display"]],
		amount: json["amount"],
	);
	
	Map<String, dynamic> toJson() => {
		"display": displayValues.reverse[display],
		"amount": amount,
	};
}

enum Display { STRONG_NHN_FONT_COLOR_1_BA0_E2_0_IM_FONT_STRONG }

final displayValues = EnumValues({
	"<strong>Nhận <font color=\"#1ba0e2\">0 điểm</font></strong>": Display.STRONG_NHN_FONT_COLOR_1_BA0_E2_0_IM_FONT_STRONG
});

class HotelPromoType {
	PromoType promoType;
	String promoDescription;
	
	HotelPromoType({
		this.promoType,
		this.promoDescription,
	});
	
	factory HotelPromoType.fromJson(Map<String, dynamic> json) => HotelPromoType(
		promoType: promoTypeValues.map[json["promoType"]],
		promoDescription: json["promoDescription"] == null ? null : json["promoDescription"],
	);
	
	Map<String, dynamic> toJson() => {
		"promoType": promoTypeValues.reverse[promoType],
		"promoDescription": promoDescription == null ? null : promoDescription,
	};
}

enum PromoType { SALE }

final promoTypeValues = EnumValues({
	"SALE": PromoType.SALE
});

class ImageWithCaption {
	Caption caption;
	String url;
	dynamic width;
	dynamic height;
	String thumbnailUrl;
	String assetOrder;
	
	ImageWithCaption({
		this.caption,
		this.url,
		this.width,
		this.height,
		this.thumbnailUrl,
		this.assetOrder,
	});
	
	factory ImageWithCaption.fromJson(Map<String, dynamic> json) => ImageWithCaption(
		caption: json["caption"] == null ? null : captionValues.map[json["caption"]],
		url: json["url"],
		width: json["width"],
		height: json["height"],
		thumbnailUrl: json["thumbnailUrl"],
		assetOrder: json["assetOrder"],
	);
	
	Map<String, dynamic> toJson() => {
		"caption": caption == null ? null : captionValues.reverse[caption],
		"url": url,
		"width": width,
		"height": height,
		"thumbnailUrl": thumbnailUrl,
		"assetOrder": assetOrder,
	};
}

enum Caption { GUESTROOM_VIEW, GUESTROOM, BATHROOM, FEATURED_IMAGE }

final captionValues = EnumValues({
	"Bathroom": Caption.BATHROOM,
	"Featured Image": Caption.FEATURED_IMAGE,
	"Guestroom": Caption.GUESTROOM,
	"Guestroom View": Caption.GUESTROOM_VIEW
});

class InventoryLabels {
	LabelDisplayData roomRecommendation;
	
	InventoryLabels({
		this.roomRecommendation,
	});
	
	factory InventoryLabels.fromJson(Map<String, dynamic> json) => InventoryLabels(
		roomRecommendation: json["ROOM_RECOMMENDATION"] == null ? null : LabelDisplayData.fromJson(json["ROOM_RECOMMENDATION"]),
	);
	
	Map<String, dynamic> toJson() => {
		"ROOM_RECOMMENDATION": roomRecommendation == null ? null : roomRecommendation.toJson(),
	};
}

class LabelDisplayData {
	String iconId;
	String shortDescription;
	String longDescription;
	bool overrideProviderLabel;
	String iconUrl;
	String shortFormattedDescription;
	String longFormattedDescription;
	String backgroundColor;
	
	LabelDisplayData({
		this.iconId,
		this.shortDescription,
		this.longDescription,
		this.overrideProviderLabel,
		this.iconUrl,
		this.shortFormattedDescription,
		this.longFormattedDescription,
		this.backgroundColor,
	});
	
	factory LabelDisplayData.fromJson(Map<String, dynamic> json) => LabelDisplayData(
		iconId: json["iconId"],
		shortDescription: json["shortDescription"],
		longDescription: json["longDescription"],
		overrideProviderLabel: json["overrideProviderLabel"],
		iconUrl: json["iconUrl"],
		shortFormattedDescription: json["shortFormattedDescription"],
		longFormattedDescription: json["longFormattedDescription"],
		backgroundColor: json["backgroundColor"] == null ? null : json["backgroundColor"],
	);
	
	Map<String, dynamic> toJson() => {
		"iconId": iconId,
		"shortDescription": shortDescription,
		"longDescription": longDescription,
		"overrideProviderLabel": overrideProviderLabel,
		"iconUrl": iconUrl,
		"shortFormattedDescription": shortFormattedDescription,
		"longFormattedDescription": longFormattedDescription,
		"backgroundColor": backgroundColor == null ? null : backgroundColor,
	};
}

class RateDisplay {
	BaseFare baseFare;
	BaseFare fees;
	BaseFare taxes;
	BaseFare totalFare;
	String numOfDecimalPoint;
	
	RateDisplay({
		this.baseFare,
		this.fees,
		this.taxes,
		this.totalFare,
		this.numOfDecimalPoint,
	});
	
	factory RateDisplay.fromJson(Map<String, dynamic> json) => RateDisplay(
		baseFare: BaseFare.fromJson(json["baseFare"]),
		fees: BaseFare.fromJson(json["fees"]),
		taxes: BaseFare.fromJson(json["taxes"]),
		totalFare: BaseFare.fromJson(json["totalFare"]),
		numOfDecimalPoint: json["numOfDecimalPoint"],
	);
	
	Map<String, dynamic> toJson() => {
		"baseFare": baseFare.toJson(),
		"fees": fees.toJson(),
		"taxes": taxes.toJson(),
		"totalFare": totalFare.toJson(),
		"numOfDecimalPoint": numOfDecimalPoint,
	};
}

class BaseFare {
	Currency currency;
	String amount;
	
	BaseFare({
		this.currency,
		this.amount,
	});
	
	factory BaseFare.fromJson(Map<String, dynamic> json) => BaseFare(
		currency: currencyValues.map[json["currency"]],
		amount: json["amount"],
	);
	
	Map<String, dynamic> toJson() => {
		"currency": currencyValues.reverse[currency],
		"amount": amount,
	};
}

enum Currency { VND }

final currencyValues = EnumValues({
	"VND": Currency.VND
});

class RateInfo {
	dynamic savings;
	List<FeeElement> fees;
	List<FeeElement> taxes;
	List<dynamic> surcharges;
	
	RateInfo({
		this.savings,
		this.fees,
		this.taxes,
		this.surcharges,
	});
	
	factory RateInfo.fromJson(Map<String, dynamic> json) => RateInfo(
		savings: json["savings"],
		fees: List<FeeElement>.from(json["fees"].map((x) => FeeElement.fromJson(x))),
		taxes: List<FeeElement>.from(json["taxes"].map((x) => FeeElement.fromJson(x))),
		surcharges: List<dynamic>.from(json["surcharges"].map((x) => x)),
	);
	
	Map<String, dynamic> toJson() => {
		"savings": savings,
		"fees": List<dynamic>.from(fees.map((x) => x.toJson())),
		"taxes": List<dynamic>.from(taxes.map((x) => x.toJson())),
		"surcharges": List<dynamic>.from(surcharges.map((x) => x)),
	};
}

class FeeElement {
	FeeDescription description;
	String amount;
	
	FeeElement({
		this.description,
		this.amount,
	});
	
	factory FeeElement.fromJson(Map<String, dynamic> json) => FeeElement(
		description: feeDescriptionValues.map[json["description"]],
		amount: json["amount"],
	);
	
	Map<String, dynamic> toJson() => {
		"description": feeDescriptionValues.reverse[description],
		"amount": amount,
	};
}

enum FeeDescription { SERVICE_FEE, TAX }

final feeDescriptionValues = EnumValues({
	"Service Fee": FeeDescription.SERVICE_FEE,
	"Tax": FeeDescription.TAX
});

enum RateType { PAY_NOW }

final rateTypeValues = EnumValues({
	"PAY_NOW": RateType.PAY_NOW
});

class RoomCancellationPolicy {
	CancellationPolicyLabel cancellationPolicyLabel;
	String cancellationPolicyString;
	String providerCancellationPolicyString;
	bool freeCancel;
	bool refundable;
	List<CancellationPolicyInfo> cancellationPolicyInfos;
	List<AdditionalCancellationPolicyInfo> additionalCancellationPolicyInfo;
	
	RoomCancellationPolicy({
		this.cancellationPolicyLabel,
		this.cancellationPolicyString,
		this.providerCancellationPolicyString,
		this.freeCancel,
		this.refundable,
		this.cancellationPolicyInfos,
		this.additionalCancellationPolicyInfo,
	});
	
	factory RoomCancellationPolicy.fromJson(Map<String, dynamic> json) => RoomCancellationPolicy(
		cancellationPolicyLabel: cancellationPolicyLabelValues.map[json["cancellationPolicyLabel"]],
		cancellationPolicyString: json["cancellationPolicyString"],
		providerCancellationPolicyString: json["providerCancellationPolicyString"] == null ? null : json["providerCancellationPolicyString"],
		freeCancel: json["freeCancel"],
		refundable: json["refundable"],
		cancellationPolicyInfos: json["cancellationPolicyInfos"] == null ? null : List<CancellationPolicyInfo>.from(json["cancellationPolicyInfos"].map((x) => CancellationPolicyInfo.fromJson(x))),
		additionalCancellationPolicyInfo: json["additionalCancellationPolicyInfo"] == null ? null : List<AdditionalCancellationPolicyInfo>.from(json["additionalCancellationPolicyInfo"].map((x) => additionalCancellationPolicyInfoValues.map[x])),
	);
	
	Map<String, dynamic> toJson() => {
		"cancellationPolicyLabel": cancellationPolicyLabelValues.reverse[cancellationPolicyLabel],
		"cancellationPolicyString": cancellationPolicyString,
		"providerCancellationPolicyString": providerCancellationPolicyString == null ? null : providerCancellationPolicyString,
		"freeCancel": freeCancel,
		"refundable": refundable,
		"cancellationPolicyInfos": cancellationPolicyInfos == null ? null : List<dynamic>.from(cancellationPolicyInfos.map((x) => x.toJson())),
		"additionalCancellationPolicyInfo": additionalCancellationPolicyInfo == null ? null : List<dynamic>.from(additionalCancellationPolicyInfo.map((x) => additionalCancellationPolicyInfoValues.reverse[x])),
	};
}

enum AdditionalCancellationPolicyInfo { ROOM_TYPE_POLICY_INFO, HOTEL_LOCAL_TIME_POLICY_INFO }

final additionalCancellationPolicyInfoValues = EnumValues({
	"hotelLocalTimePolicyInfo": AdditionalCancellationPolicyInfo.HOTEL_LOCAL_TIME_POLICY_INFO,
	"roomTypePolicyInfo": AdditionalCancellationPolicyInfo.ROOM_TYPE_POLICY_INFO
});

class CancellationPolicyInfo {
	AppliedDateInfoDescription appliedDateInfoDescription;
	AppliedDate appliedStartDate;
	AppliedDate appliedEndDate;
	PolicyInfoDetail policyInfoDetail;
	
	CancellationPolicyInfo({
		this.appliedDateInfoDescription,
		this.appliedStartDate,
		this.appliedEndDate,
		this.policyInfoDetail,
	});
	
	factory CancellationPolicyInfo.fromJson(Map<String, dynamic> json) => CancellationPolicyInfo(
		appliedDateInfoDescription: appliedDateInfoDescriptionValues.map[json["appliedDateInfoDescription"]],
		appliedStartDate: AppliedDate.fromJson(json["appliedStartDate"]),
		appliedEndDate: AppliedDate.fromJson(json["appliedEndDate"]),
		policyInfoDetail: PolicyInfoDetail.fromJson(json["policyInfoDetail"]),
	);
	
	Map<String, dynamic> toJson() => {
		"appliedDateInfoDescription": appliedDateInfoDescriptionValues.reverse[appliedDateInfoDescription],
		"appliedStartDate": appliedStartDate.toJson(),
		"appliedEndDate": appliedEndDate.toJson(),
		"policyInfoDetail": policyInfoDetail.toJson(),
	};
}

enum AppliedDateInfoDescription { THE_13_THG_1220190500, THE_14_THG_1220191500, HOTEL_CHECK_IN_DATE_INFO }

final appliedDateInfoDescriptionValues = EnumValues({
	"hotelCheckInDateInfo": AppliedDateInfoDescription.HOTEL_CHECK_IN_DATE_INFO,
	"13-thg 12-2019, 05:00": AppliedDateInfoDescription.THE_13_THG_1220190500,
	"14-thg 12-2019, 15:00": AppliedDateInfoDescription.THE_14_THG_1220191500
});

class AppliedDate {
	MonthDayYear monthDayYear;
	HourMinute hourMinute;
	
	AppliedDate({
		this.monthDayYear,
		this.hourMinute,
	});
	
	factory AppliedDate.fromJson(Map<String, dynamic> json) => AppliedDate(
		monthDayYear: MonthDayYear.fromJson(json["monthDayYear"]),
		hourMinute: HourMinute.fromJson(json["hourMinute"]),
	);
	
	Map<String, dynamic> toJson() => {
		"monthDayYear": monthDayYear.toJson(),
		"hourMinute": hourMinute.toJson(),
	};
}

class HourMinute {
	String hour;
	String minute;
	
	HourMinute({
		this.hour,
		this.minute,
	});
	
	factory HourMinute.fromJson(Map<String, dynamic> json) => HourMinute(
		hour: json["hour"],
		minute: json["minute"],
	);
	
	Map<String, dynamic> toJson() => {
		"hour": hour,
		"minute": minute,
	};
}

class MonthDayYear {
	String month;
	String day;
	String year;
	
	MonthDayYear({
		this.month,
		this.day,
		this.year,
	});
	
	factory MonthDayYear.fromJson(Map<String, dynamic> json) => MonthDayYear(
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

class PolicyInfoDetail {
	PolicyInfoDetailFee fee;
	Type type;
	PolicyInfoDetailDescription description;
	
	PolicyInfoDetail({
		this.fee,
		this.type,
		this.description,
	});
	
	factory PolicyInfoDetail.fromJson(Map<String, dynamic> json) => PolicyInfoDetail(
		fee: PolicyInfoDetailFee.fromJson(json["fee"]),
		type: typeValues.map[json["type"]],
		description: policyInfoDetailDescriptionValues.map[json["description"]],
	);
	
	Map<String, dynamic> toJson() => {
		"fee": fee.toJson(),
		"type": typeValues.reverse[type],
		"description": policyInfoDetailDescriptionValues.reverse[description],
	};
}

enum PolicyInfoDetailDescription { FREE_CANCELLATION_POLICY_INFO, CANCELLATION_FEE_POLICY_INFO, FULL_CHARGE_POLICY_INFO }

final policyInfoDetailDescriptionValues = EnumValues({
	"cancellationFeePolicyInfo": PolicyInfoDetailDescription.CANCELLATION_FEE_POLICY_INFO,
	"freeCancellationPolicyInfo": PolicyInfoDetailDescription.FREE_CANCELLATION_POLICY_INFO,
	"fullChargePolicyInfo": PolicyInfoDetailDescription.FULL_CHARGE_POLICY_INFO
});

class PolicyInfoDetailFee {
	BaseFare currencyValue;
	String numOfDecimalPoint;
	
	PolicyInfoDetailFee({
		this.currencyValue,
		this.numOfDecimalPoint,
	});
	
	factory PolicyInfoDetailFee.fromJson(Map<String, dynamic> json) => PolicyInfoDetailFee(
		currencyValue: BaseFare.fromJson(json["currencyValue"]),
		numOfDecimalPoint: json["numOfDecimalPoint"],
	);
	
	Map<String, dynamic> toJson() => {
		"currencyValue": currencyValue.toJson(),
		"numOfDecimalPoint": numOfDecimalPoint,
	};
}

enum Type { FREE_CANCELLATION, CANCELLATION_FEE_APPLIES, FULL_CHARGE }

final typeValues = EnumValues({
	"CANCELLATION_FEE_APPLIES": Type.CANCELLATION_FEE_APPLIES,
	"FREE_CANCELLATION": Type.FREE_CANCELLATION,
	"FULL_CHARGE": Type.FULL_CHARGE
});

enum CancellationPolicyLabel { T_PHNG_NY_KHNG_C_HON_TIN, MIN_PH_HY_PHNG_N_13_THG_122019 }

final cancellationPolicyLabelValues = EnumValues({
	"Miễn phí hủy phòng đến 13-thg 12-2019": CancellationPolicyLabel.MIN_PH_HY_PHNG_N_13_THG_122019,
	"Đặt phòng này không được hoàn tiền.": CancellationPolicyLabel.T_PHNG_NY_KHNG_C_HON_TIN
});

class RoomDisplayInfo {
	String finalPriceInfo;
	String finalPriceInfoPerRoom;
	String finalPriceInfoRoomDetail;
	
	RoomDisplayInfo({
		this.finalPriceInfo,
		this.finalPriceInfoPerRoom,
		this.finalPriceInfoRoomDetail,
	});
	
	factory RoomDisplayInfo.fromJson(Map<String, dynamic> json) => RoomDisplayInfo(
		finalPriceInfo: json["finalPriceInfo"],
		finalPriceInfoPerRoom: json["finalPriceInfoPerRoom"],
		finalPriceInfoRoomDetail: json["finalPriceInfoRoomDetail"],
	);
	
	Map<String, dynamic> toJson() => {
		"finalPriceInfo": finalPriceInfo,
		"finalPriceInfoPerRoom": finalPriceInfoPerRoom,
		"finalPriceInfoRoomDetail": finalPriceInfoRoomDetail,
	};
}

class RoomListBanners {
	RoomRecommendation roomRecommendation;
	
	RoomListBanners({
		this.roomRecommendation,
	});
	
	factory RoomListBanners.fromJson(Map<String, dynamic> json) => RoomListBanners(
		roomRecommendation: RoomRecommendation.fromJson(json["ROOM_RECOMMENDATION"]),
	);
	
	Map<String, dynamic> toJson() => {
		"ROOM_RECOMMENDATION": roomRecommendation.toJson(),
	};
}

class RoomRecommendation {
	String iconUrl;
	String description;
	String formattedDescription;
	String backgroundColor;
	
	RoomRecommendation({
		this.iconUrl,
		this.description,
		this.formattedDescription,
		this.backgroundColor,
	});
	
	factory RoomRecommendation.fromJson(Map<String, dynamic> json) => RoomRecommendation(
		iconUrl: json["iconUrl"],
		description: json["description"],
		formattedDescription: json["formattedDescription"],
		backgroundColor: json["backgroundColor"],
	);
	
	Map<String, dynamic> toJson() => {
		"iconUrl": iconUrl,
		"description": description,
		"formattedDescription": formattedDescription,
		"backgroundColor": backgroundColor,
	};
}

class VariantContexts {
	bool isCollapseAll;
	String roomImprovementDisplay;
	bool isNewLayout;
	bool isExpandAllRooms;
	bool isShowChevron;
	bool haspromolabel;
	
	VariantContexts({
		this.isCollapseAll,
		this.roomImprovementDisplay,
		this.isNewLayout,
		this.isExpandAllRooms,
		this.isShowChevron,
		this.haspromolabel,
	});
	
	factory VariantContexts.fromJson(Map<String, dynamic> json) => VariantContexts(
		isCollapseAll: json["isCollapseAll"],
		roomImprovementDisplay: json["roomImprovementDisplay"],
		isNewLayout: json["isNewLayout"],
		isExpandAllRooms: json["isExpandAllRooms"],
		isShowChevron: json["isShowChevron"],
		haspromolabel: json["HASPROMOLABEL"],
	);
	
	Map<String, dynamic> toJson() => {
		"isCollapseAll": isCollapseAll,
		"roomImprovementDisplay": roomImprovementDisplay,
		"isNewLayout": isNewLayout,
		"isExpandAllRooms": isExpandAllRooms,
		"isShowChevron": isShowChevron,
		"HASPROMOLABEL": haspromolabel,
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
