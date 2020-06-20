class HotelsModel {
	Data data;
	dynamic userContext;
	
	HotelsModel({
		this.data,
		this.userContext,
	});
	
	factory HotelsModel.fromJson(Map<String, dynamic> json) => HotelsModel(
		data: Data.fromJson(json["data"]),
		userContext: json["userContext"],
	);
	
	Map<String, dynamic> toJson() => {
		"data": data.toJson(),
		"userContext": userContext,
	};
}

class Data {
	String searchId;
	String numOfHotels;
	GeoLocation geoLocation;
	dynamic tagManagerLocation;
	String countryName;
	List<Entry> entries;
	List<dynamic> extendedEntries;
	List<FeaturedHotel> featuredHotels;
	AccomPriceFilterData accomPriceFilterData;
	FilterDisplayInfo filterDisplayInfo;
	HotelDisplayInfo hotelDisplayInfo;
	String countryTaxFactor;
	String searchResultDisplayName;
	SeoInfo seoInfo;
	FbGeoInformation fbGeoInformation;
	String status;
	dynamic failedStatusReason;
	dynamic message;
	dynamic userTagContext;
	dynamic communicationBanner;
	bool showResponseAfterLogin;
	VariantContexts variantContexts;
	Layout layout;
	FeaturedHotelsDisplay featuredHotelsDisplay;
	Contexts contexts;
	
	Data({
		this.searchId,
		this.numOfHotels,
		this.geoLocation,
		this.tagManagerLocation,
		this.countryName,
		this.entries,
		this.extendedEntries,
		this.featuredHotels,
		this.accomPriceFilterData,
		this.filterDisplayInfo,
		this.hotelDisplayInfo,
		this.countryTaxFactor,
		this.searchResultDisplayName,
		this.seoInfo,
		this.fbGeoInformation,
		this.status,
		this.failedStatusReason,
		this.message,
		this.userTagContext,
		this.communicationBanner,
		this.showResponseAfterLogin,
		this.variantContexts,
		this.layout,
		this.featuredHotelsDisplay,
		this.contexts,
	});
	
	factory Data.fromJson(Map<String, dynamic> json) => Data(
		searchId: json["searchId"],
		numOfHotels: json["numOfHotels"],
		geoLocation: GeoLocation.fromJson(json["geoLocation"]),
		tagManagerLocation: json["tagManagerLocation"],
		countryName: json["countryName"],
		entries: List<Entry>.from(json["entries"].map((x) => Entry.fromJson(x))),
		extendedEntries: List<dynamic>.from(json["extendedEntries"].map((x) => x)),
		featuredHotels: List<FeaturedHotel>.from(json["featuredHotels"].map((x) => FeaturedHotel.fromJson(x))),
		accomPriceFilterData: AccomPriceFilterData.fromJson(json["accomPriceFilterData"]),
		filterDisplayInfo: FilterDisplayInfo.fromJson(json["filterDisplayInfo"]),
		hotelDisplayInfo: HotelDisplayInfo.fromJson(json["hotelDisplayInfo"]),
		countryTaxFactor: json["countryTaxFactor"],
		searchResultDisplayName: json["searchResultDisplayName"],
		seoInfo: SeoInfo.fromJson(json["seoInfo"]),
		fbGeoInformation: FbGeoInformation.fromJson(json["fbGeoInformation"]),
		status: json["status"],
		failedStatusReason: json["failedStatusReason"],
		message: json["message"],
		userTagContext: json["userTagContext"],
		communicationBanner: json["communicationBanner"],
		showResponseAfterLogin: json["showResponseAfterLogin"],
		variantContexts: VariantContexts.fromJson(json["variantContexts"]),
		layout: Layout.fromJson(json["layout"]),
		featuredHotelsDisplay: FeaturedHotelsDisplay.fromJson(json["featuredHotelsDisplay"]),
		contexts: Contexts.fromJson(json["contexts"]),
	);
	
	Map<String, dynamic> toJson() => {
		"searchId": searchId,
		"numOfHotels": numOfHotels,
		"geoLocation": geoLocation.toJson(),
		"tagManagerLocation": tagManagerLocation,
		"countryName": countryName,
		"entries": List<dynamic>.from(entries.map((x) => x.toJson())),
		"extendedEntries": List<dynamic>.from(extendedEntries.map((x) => x)),
		"featuredHotels": List<dynamic>.from(featuredHotels.map((x) => x.toJson())),
		"accomPriceFilterData": accomPriceFilterData.toJson(),
		"filterDisplayInfo": filterDisplayInfo.toJson(),
		"hotelDisplayInfo": hotelDisplayInfo.toJson(),
		"countryTaxFactor": countryTaxFactor,
		"searchResultDisplayName": searchResultDisplayName,
		"seoInfo": seoInfo.toJson(),
		"fbGeoInformation": fbGeoInformation.toJson(),
		"status": status,
		"failedStatusReason": failedStatusReason,
		"message": message,
		"userTagContext": userTagContext,
		"communicationBanner": communicationBanner,
		"showResponseAfterLogin": showResponseAfterLogin,
		"variantContexts": variantContexts.toJson(),
		"layout": layout.toJson(),
		"featuredHotelsDisplay": featuredHotelsDisplay.toJson(),
		"contexts": contexts.toJson(),
	};
}

class AccomPriceFilterData {
	String maxPriceFilter;
	String minPriceFilter;
	
	AccomPriceFilterData({
		this.maxPriceFilter,
		this.minPriceFilter,
	});
	
	factory AccomPriceFilterData.fromJson(Map<String, dynamic> json) => AccomPriceFilterData(
		maxPriceFilter: json["maxPriceFilter"],
		minPriceFilter: json["minPriceFilter"],
	);
	
	Map<String, dynamic> toJson() => {
		"maxPriceFilter": maxPriceFilter,
		"minPriceFilter": minPriceFilter,
	};
}

class Contexts {
	dynamic metasearchToken;
	dynamic encryptedAccessCode;
	
	Contexts({
		this.metasearchToken,
		this.encryptedAccessCode,
	});
	
	factory Contexts.fromJson(Map<String, dynamic> json) => Contexts(
		metasearchToken: json["metasearchToken"],
		encryptedAccessCode: json["encryptedAccessCode"],
	);
	
	Map<String, dynamic> toJson() => {
		"metasearchToken": metasearchToken,
		"encryptedAccessCode": encryptedAccessCode,
	};
}

class Entry {
	String id;
	String name;
	String displayName;
	dynamic address;
	String region;
	String starRating;
	String userRating;
	String numReviews;
	UserRatingInfo userRatingInfo;
	String latitude;
	String longitude;
	String lowRate;
	dynamic highRate;
	List<ShowedFacilityType> showedFacilityTypes;
	dynamic lastBookingDeltaTime;
	dynamic numPeopleViews;
	dynamic propertyListing;
	InventoryUnitDisplay inventoryUnitDisplay;
	String imageUrl;
	List<String> imageUrls;
	String hotelSeoUrl;
	List<dynamic> extraInfos;
	HotelInventorySummary hotelInventorySummary;
	ThirdPartyHotelRatingInfoMap thirdPartyHotelRatingInfoMap;
	String loyaltyAmount;
	HotelLoyaltyDisplay hotelLoyaltyDisplay;
	AccomLoyaltyEligibilityStatus accomLoyaltyEligibilityStatus;
	AccomPropertyType accomPropertyType;
	InsiderDisplay insiderDisplay;
	dynamic addOns;
	
	Entry({
		this.id,
		this.name,
		this.displayName,
		this.address,
		this.region,
		this.starRating,
		this.userRating,
		this.numReviews,
		this.userRatingInfo,
		this.latitude,
		this.longitude,
		this.lowRate,
		this.highRate,
		this.showedFacilityTypes,
		this.lastBookingDeltaTime,
		this.numPeopleViews,
		this.propertyListing,
		this.inventoryUnitDisplay,
		this.imageUrl,
		this.imageUrls,
		this.hotelSeoUrl,
		this.extraInfos,
		this.hotelInventorySummary,
		this.thirdPartyHotelRatingInfoMap,
		this.loyaltyAmount,
		this.hotelLoyaltyDisplay,
		this.accomLoyaltyEligibilityStatus,
		this.accomPropertyType,
		this.insiderDisplay,
		this.addOns,
	});
	
	factory Entry.fromJson(Map<String, dynamic> json) => Entry(
		id: json["id"],
		name: json["name"],
		displayName: json["displayName"],
		address: json["address"],
		region: json["region"],
		starRating: json["starRating"],
		userRating: json["userRating"] == null ? null : json["userRating"],
		numReviews: json["numReviews"],
		userRatingInfo: userRatingInfoValues.map[json["userRatingInfo"]],
		latitude: json["latitude"],
		longitude: json["longitude"],
		lowRate: json["lowRate"],
		highRate: json["highRate"],
		showedFacilityTypes: List<ShowedFacilityType>.from(json["showedFacilityTypes"].map((x) => showedFacilityTypeValues.map[x])),
		lastBookingDeltaTime: json["lastBookingDeltaTime"],
		numPeopleViews: json["numPeopleViews"],
		propertyListing: json["propertyListing"],
		inventoryUnitDisplay: InventoryUnitDisplay.fromJson(json["inventoryUnitDisplay"]),
		imageUrl: json["imageUrl"],
		imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
		hotelSeoUrl: json["hotelSeoUrl"],
		extraInfos: List<dynamic>.from(json["extraInfos"].map((x) => x)),
		hotelInventorySummary: HotelInventorySummary.fromJson(json["hotelInventorySummary"]),
		thirdPartyHotelRatingInfoMap: ThirdPartyHotelRatingInfoMap.fromJson(json["thirdPartyHotelRatingInfoMap"]),
		loyaltyAmount: json["loyaltyAmount"],
		hotelLoyaltyDisplay: HotelLoyaltyDisplay.fromJson(json["hotelLoyaltyDisplay"]),
		accomLoyaltyEligibilityStatus: accomLoyaltyEligibilityStatusValues.map[json["accomLoyaltyEligibilityStatus"]],
		accomPropertyType: accomPropertyTypeValues.map[json["accomPropertyType"]],
		insiderDisplay: InsiderDisplay.fromJson(json["insiderDisplay"]),
		addOns: json["addOns"],
	);
	
	Map<String, dynamic> toJson() => {
		"id": id,
		"name": name,
		"displayName": displayName,
		"address": address,
		"region": region,
		"starRating": starRating,
		"userRating": userRating == null ? null : userRating,
		"numReviews": numReviews,
		"userRatingInfo": userRatingInfoValues.reverse[userRatingInfo],
		"latitude": latitude,
		"longitude": longitude,
		"lowRate": lowRate,
		"highRate": highRate,
		"showedFacilityTypes": List<dynamic>.from(showedFacilityTypes.map((x) => showedFacilityTypeValues.reverse[x])),
		"lastBookingDeltaTime": lastBookingDeltaTime,
		"numPeopleViews": numPeopleViews,
		"propertyListing": propertyListing,
		"inventoryUnitDisplay": inventoryUnitDisplay.toJson(),
		"imageUrl": imageUrl,
		"imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
		"hotelSeoUrl": hotelSeoUrl,
		"extraInfos": List<dynamic>.from(extraInfos.map((x) => x)),
		"hotelInventorySummary": hotelInventorySummary.toJson(),
		"thirdPartyHotelRatingInfoMap": thirdPartyHotelRatingInfoMap.toJson(),
		"loyaltyAmount": loyaltyAmount,
		"hotelLoyaltyDisplay": hotelLoyaltyDisplay.toJson(),
		"accomLoyaltyEligibilityStatus": accomLoyaltyEligibilityStatusValues.reverse[accomLoyaltyEligibilityStatus],
		"accomPropertyType": accomPropertyTypeValues.reverse[accomPropertyType],
		"insiderDisplay": insiderDisplay.toJson(),
		"addOns": addOns,
	};
}

enum AccomLoyaltyEligibilityStatus { USER_NOT_ELIGIBLE }

final accomLoyaltyEligibilityStatusValues = EnumValues({
	"USER_NOT_ELIGIBLE": AccomLoyaltyEligibilityStatus.USER_NOT_ELIGIBLE
});

enum AccomPropertyType { KHCH_SN, NH_NGH, KHU_NGH_DNG }

final accomPropertyTypeValues = EnumValues({
	"Khách sạn": AccomPropertyType.KHCH_SN,
	"Khu nghỉ dưỡng": AccomPropertyType.KHU_NGH_DNG,
	"Nhà nghỉ": AccomPropertyType.NH_NGH
});

class HotelInventorySummary {
	RateDisplay cheapestRateDisplay;
	RateDisplay originalRateDisplay;
	RateDisplay strikethroughRateDisplay;
	RateDisplay propertyCurrencyRateDisplay;
	RateDisplay propertyCurrencyOriginalRateDisplay;
	dynamic rescheduleRateDisplay;
	dynamic bundledRateDisplay;
	String providerId;
	HotelPromoType hotelPromoType;
	dynamic labelDisplayData;
	List<AvailableRateType> availableRateTypes;
	HotelRibbonDisplay hotelRibbonDisplay;
	dynamic isCashback;
	HotelRoomCcGuaranteeRequirementDisplay hotelRoomCcGuaranteeRequirementDisplay;
	dynamic extraBedSearchSummary;
	InventoryLabelDisplay inventoryLabelDisplay;
	
	HotelInventorySummary({
		this.cheapestRateDisplay,
		this.originalRateDisplay,
		this.strikethroughRateDisplay,
		this.propertyCurrencyRateDisplay,
		this.propertyCurrencyOriginalRateDisplay,
		this.rescheduleRateDisplay,
		this.bundledRateDisplay,
		this.providerId,
		this.hotelPromoType,
		this.labelDisplayData,
		this.availableRateTypes,
		this.hotelRibbonDisplay,
		this.isCashback,
		this.hotelRoomCcGuaranteeRequirementDisplay,
		this.extraBedSearchSummary,
		this.inventoryLabelDisplay,
	});
	
	factory HotelInventorySummary.fromJson(Map<String, dynamic> json) => HotelInventorySummary(
		cheapestRateDisplay: RateDisplay.fromJson(json["cheapestRateDisplay"]),
		originalRateDisplay: RateDisplay.fromJson(json["originalRateDisplay"]),
		strikethroughRateDisplay: RateDisplay.fromJson(json["strikethroughRateDisplay"]),
		propertyCurrencyRateDisplay: json["propertyCurrencyRateDisplay"] == null ? null : RateDisplay.fromJson(json["propertyCurrencyRateDisplay"]),
		propertyCurrencyOriginalRateDisplay: json["propertyCurrencyOriginalRateDisplay"] == null ? null : RateDisplay.fromJson(json["propertyCurrencyOriginalRateDisplay"]),
		rescheduleRateDisplay: json["rescheduleRateDisplay"],
		bundledRateDisplay: json["bundledRateDisplay"],
		providerId: json["providerId"],
		hotelPromoType: json["hotelPromoType"] == null ? null : HotelPromoType.fromJson(json["hotelPromoType"]),
		labelDisplayData: json["labelDisplayData"],
		availableRateTypes: List<AvailableRateType>.from(json["availableRateTypes"].map((x) => availableRateTypeValues.map[x])),
		hotelRibbonDisplay: HotelRibbonDisplay.fromJson(json["hotelRibbonDisplay"]),
		isCashback: json["isCashback"],
		hotelRoomCcGuaranteeRequirementDisplay: json["hotelRoomCCGuaranteeRequirementDisplay"] == null ? null : HotelRoomCcGuaranteeRequirementDisplay.fromJson(json["hotelRoomCCGuaranteeRequirementDisplay"]),
		extraBedSearchSummary: json["extraBedSearchSummary"],
		inventoryLabelDisplay: json["inventoryLabelDisplay"] == null ? null : InventoryLabelDisplay.fromJson(json["inventoryLabelDisplay"]),
	);
	
	Map<String, dynamic> toJson() => {
		"cheapestRateDisplay": cheapestRateDisplay.toJson(),
		"originalRateDisplay": originalRateDisplay.toJson(),
		"strikethroughRateDisplay": strikethroughRateDisplay.toJson(),
		"propertyCurrencyRateDisplay": propertyCurrencyRateDisplay == null ? null : propertyCurrencyRateDisplay.toJson(),
		"propertyCurrencyOriginalRateDisplay": propertyCurrencyOriginalRateDisplay == null ? null : propertyCurrencyOriginalRateDisplay.toJson(),
		"rescheduleRateDisplay": rescheduleRateDisplay,
		"bundledRateDisplay": bundledRateDisplay,
		"providerId": providerId,
		"hotelPromoType": hotelPromoType == null ? null : hotelPromoType.toJson(),
		"labelDisplayData": labelDisplayData,
		"availableRateTypes": List<dynamic>.from(availableRateTypes.map((x) => availableRateTypeValues.reverse[x])),
		"hotelRibbonDisplay": hotelRibbonDisplay.toJson(),
		"isCashback": isCashback,
		"hotelRoomCCGuaranteeRequirementDisplay": hotelRoomCcGuaranteeRequirementDisplay == null ? null : hotelRoomCcGuaranteeRequirementDisplay.toJson(),
		"extraBedSearchSummary": extraBedSearchSummary,
		"inventoryLabelDisplay": inventoryLabelDisplay == null ? null : inventoryLabelDisplay.toJson(),
	};
}

enum AvailableRateType { PAY_AT_PROPERTY, PAY_NOW }

final availableRateTypeValues = EnumValues({
	"PAY_AT_PROPERTY": AvailableRateType.PAY_AT_PROPERTY,
	"PAY_NOW": AvailableRateType.PAY_NOW
});

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

enum PromoType { SALE, LAST_MINUTE }

final promoTypeValues = EnumValues({
	"LAST_MINUTE": PromoType.LAST_MINUTE,
	"SALE": PromoType.SALE
});

class HotelRibbonDisplay {
	dynamic url;
	dynamic label;
	
	HotelRibbonDisplay({
		this.url,
		this.label,
	});
	
	factory HotelRibbonDisplay.fromJson(Map<String, dynamic> json) => HotelRibbonDisplay(
		url: json["url"],
		label: json["label"],
	);
	
	Map<String, dynamic> toJson() => {
		"url": url,
		"label": label,
	};
}

class HotelRoomCcGuaranteeRequirementDisplay {
	bool ccRequired;
	bool csTokenRequired;
	List<SupportedCcType> supportedCcTypes;
	
	HotelRoomCcGuaranteeRequirementDisplay({
		this.ccRequired,
		this.csTokenRequired,
		this.supportedCcTypes,
	});
	
	factory HotelRoomCcGuaranteeRequirementDisplay.fromJson(Map<String, dynamic> json) => HotelRoomCcGuaranteeRequirementDisplay(
		ccRequired: json["ccRequired"],
		csTokenRequired: json["csTokenRequired"],
		supportedCcTypes: List<SupportedCcType>.from(json["supportedCCTypes"].map((x) => supportedCcTypeValues.map[x])),
	);
	
	Map<String, dynamic> toJson() => {
		"ccRequired": ccRequired,
		"csTokenRequired": csTokenRequired,
		"supportedCCTypes": List<dynamic>.from(supportedCcTypes.map((x) => supportedCcTypeValues.reverse[x])),
	};
}

enum SupportedCcType { MASTER_CARD, VISA }

final supportedCcTypeValues = EnumValues({
	"MASTER_CARD": SupportedCcType.MASTER_CARD,
	"VISA": SupportedCcType.VISA
});

class InventoryLabelDisplay {
	Label label;
	String description;
	String tagline;
	String icon;
	
	InventoryLabelDisplay({
		this.label,
		this.description,
		this.tagline,
		this.icon,
	});
	
	factory InventoryLabelDisplay.fromJson(Map<String, dynamic> json) => InventoryLabelDisplay(
		label: labelValues.map[json["label"]],
		description: json["description"],
		tagline: json["tagline"],
		icon: json["icon"],
	);
	
	Map<String, dynamic> toJson() => {
		"label": labelValues.reverse[label],
		"description": description,
		"tagline": tagline,
		"icon": icon,
	};
}

enum Label { THANH_TON_KHI_NHN_PHNG }

final labelValues = EnumValues({
	"Thanh toán khi nhận phòng": Label.THANH_TON_KHI_NHN_PHNG
});

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

enum Display { STRONG_0_IM_STRONG }

final displayValues = EnumValues({
	"<strong>0 điểm</strong>": Display.STRONG_0_IM_STRONG
});

class InsiderDisplay {
	dynamic text;
	dynamic backgroundColor;
	dynamic fontColor;
	dynamic icon;
	dynamic type;
	
	InsiderDisplay({
		this.text,
		this.backgroundColor,
		this.fontColor,
		this.icon,
		this.type,
	});
	
	factory InsiderDisplay.fromJson(Map<String, dynamic> json) => InsiderDisplay(
		text: json["text"],
		backgroundColor: json["backgroundColor"],
		fontColor: json["fontColor"],
		icon: json["icon"],
		type: json["type"],
	);
	
	Map<String, dynamic> toJson() => {
		"text": text,
		"backgroundColor": backgroundColor,
		"fontColor": fontColor,
		"icon": icon,
		"type": type,
	};
}

class InventoryUnitDisplay {
	dynamic singular;
	dynamic plural;
	dynamic pluralParentheses;
	
	InventoryUnitDisplay({
		this.singular,
		this.plural,
		this.pluralParentheses,
	});
	
	factory InventoryUnitDisplay.fromJson(Map<String, dynamic> json) => InventoryUnitDisplay(
		singular: json["singular"],
		plural: json["plural"],
		pluralParentheses: json["pluralParentheses"],
	);
	
	Map<String, dynamic> toJson() => {
		"singular": singular,
		"plural": plural,
		"pluralParentheses": pluralParentheses,
	};
}

enum ShowedFacilityType { HAS_24_HOUR_FRONT_DESK, RESTAURANT, WIFI_PUBLIC_AREA, CARPARK, BAR }

final showedFacilityTypeValues = EnumValues({
	"BAR": ShowedFacilityType.BAR,
	"CARPARK": ShowedFacilityType.CARPARK,
	"HAS_24_HOUR_FRONT_DESK": ShowedFacilityType.HAS_24_HOUR_FRONT_DESK,
	"RESTAURANT": ShowedFacilityType.RESTAURANT,
	"WIFI_PUBLIC_AREA": ShowedFacilityType.WIFI_PUBLIC_AREA
});

class ThirdPartyHotelRatingInfoMap {
	Tripadvisor tripadvisor;
	
	ThirdPartyHotelRatingInfoMap({
		this.tripadvisor,
	});
	
	factory ThirdPartyHotelRatingInfoMap.fromJson(Map<String, dynamic> json) => ThirdPartyHotelRatingInfoMap(
		tripadvisor: json["tripadvisor"] == null ? null : Tripadvisor.fromJson(json["tripadvisor"]),
	);
	
	Map<String, dynamic> toJson() => {
		"tripadvisor": tripadvisor == null ? null : tripadvisor.toJson(),
	};
}

class Tripadvisor {
	String detailUrl;
	String hotelId;
	String numReviews;
	String score;
	String ratingImage;
	
	Tripadvisor({
		this.detailUrl,
		this.hotelId,
		this.numReviews,
		this.score,
		this.ratingImage,
	});
	
	factory Tripadvisor.fromJson(Map<String, dynamic> json) => Tripadvisor(
		detailUrl: json["detailUrl"],
		hotelId: json["hotelId"],
		numReviews: json["numReviews"],
		score: json["score"],
		ratingImage: json["ratingImage"],
	);
	
	Map<String, dynamic> toJson() => {
		"detailUrl": detailUrl,
		"hotelId": hotelId,
		"numReviews": numReviews,
		"score": score,
		"ratingImage": ratingImage,
	};
}

enum UserRatingInfo { N_TNG, TIN_LI, TUYT_VI, EMPTY }

final userRatingInfoValues = EnumValues({
	"": UserRatingInfo.EMPTY,
	"Ấn tượng": UserRatingInfo.N_TNG,
	"Tiện lợi": UserRatingInfo.TIN_LI,
	"Tuyệt vời": UserRatingInfo.TUYT_VI
});

class FbGeoInformation {
	String fbCountry;
	String fbRegion;
	String fbCity;
	
	FbGeoInformation({
		this.fbCountry,
		this.fbRegion,
		this.fbCity,
	});
	
	factory FbGeoInformation.fromJson(Map<String, dynamic> json) => FbGeoInformation(
		fbCountry: json["fbCountry"],
		fbRegion: json["fbRegion"],
		fbCity: json["fbCity"],
	);
	
	Map<String, dynamic> toJson() => {
		"fbCountry": fbCountry,
		"fbRegion": fbRegion,
		"fbCity": fbCity,
	};
}

class FeaturedHotel {
	String id;
	String name;
	String displayName;
	dynamic address;
	String region;
	String starRating;
	String userRating;
	String numReviews;
	UserRatingInfo userRatingInfo;
	String latitude;
	String longitude;
	String lowRate;
	dynamic highRate;
	List<ShowedFacilityType> showedFacilityTypes;
	dynamic lastBookingDeltaTime;
	dynamic numPeopleViews;
	dynamic propertyListing;
	InventoryUnitDisplay inventoryUnitDisplay;
	String imageUrl;
	List<String> imageUrls;
	String hotelSeoUrl;
	List<dynamic> extraInfos;
	HotelInventorySummary hotelInventorySummary;
	ThirdPartyHotelRatingInfoMap thirdPartyHotelRatingInfoMap;
	String loyaltyAmount;
	HotelLoyaltyDisplay hotelLoyaltyDisplay;
	AccomLoyaltyEligibilityStatus accomLoyaltyEligibilityStatus;
	AccomPropertyType accomPropertyType;
	InsiderDisplay insiderDisplay;
	dynamic addOns;
	
	FeaturedHotel({
		this.id,
		this.name,
		this.displayName,
		this.address,
		this.region,
		this.starRating,
		this.userRating,
		this.numReviews,
		this.userRatingInfo,
		this.latitude,
		this.longitude,
		this.lowRate,
		this.highRate,
		this.showedFacilityTypes,
		this.lastBookingDeltaTime,
		this.numPeopleViews,
		this.propertyListing,
		this.inventoryUnitDisplay,
		this.imageUrl,
		this.imageUrls,
		this.hotelSeoUrl,
		this.extraInfos,
		this.hotelInventorySummary,
		this.thirdPartyHotelRatingInfoMap,
		this.loyaltyAmount,
		this.hotelLoyaltyDisplay,
		this.accomLoyaltyEligibilityStatus,
		this.accomPropertyType,
		this.insiderDisplay,
		this.addOns,
	});
	
	factory FeaturedHotel.fromJson(Map<String, dynamic> json) => FeaturedHotel(
		id: json["id"],
		name: json["name"],
		displayName: json["displayName"],
		address: json["address"],
		region: json["region"],
		starRating: json["starRating"],
		userRating: json["userRating"],
		numReviews: json["numReviews"],
		userRatingInfo: userRatingInfoValues.map[json["userRatingInfo"]],
		latitude: json["latitude"],
		longitude: json["longitude"],
		lowRate: json["lowRate"],
		highRate: json["highRate"],
		showedFacilityTypes: List<ShowedFacilityType>.from(json["showedFacilityTypes"].map((x) => showedFacilityTypeValues.map[x])),
		lastBookingDeltaTime: json["lastBookingDeltaTime"],
		numPeopleViews: json["numPeopleViews"],
		propertyListing: json["propertyListing"],
		inventoryUnitDisplay: InventoryUnitDisplay.fromJson(json["inventoryUnitDisplay"]),
		imageUrl: json["imageUrl"],
		imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
		hotelSeoUrl: json["hotelSeoUrl"],
		extraInfos: List<dynamic>.from(json["extraInfos"].map((x) => x)),
		hotelInventorySummary: HotelInventorySummary.fromJson(json["hotelInventorySummary"]),
		thirdPartyHotelRatingInfoMap: ThirdPartyHotelRatingInfoMap.fromJson(json["thirdPartyHotelRatingInfoMap"]),
		loyaltyAmount: json["loyaltyAmount"],
		hotelLoyaltyDisplay: HotelLoyaltyDisplay.fromJson(json["hotelLoyaltyDisplay"]),
		accomLoyaltyEligibilityStatus: accomLoyaltyEligibilityStatusValues.map[json["accomLoyaltyEligibilityStatus"]],
		accomPropertyType: accomPropertyTypeValues.map[json["accomPropertyType"]],
		insiderDisplay: InsiderDisplay.fromJson(json["insiderDisplay"]),
		addOns: json["addOns"],
	);
	
	Map<String, dynamic> toJson() => {
		"id": id,
		"name": name,
		"displayName": displayName,
		"address": address,
		"region": region,
		"starRating": starRating,
		"userRating": userRating,
		"numReviews": numReviews,
		"userRatingInfo": userRatingInfoValues.reverse[userRatingInfo],
		"latitude": latitude,
		"longitude": longitude,
		"lowRate": lowRate,
		"highRate": highRate,
		"showedFacilityTypes": List<dynamic>.from(showedFacilityTypes.map((x) => showedFacilityTypeValues.reverse[x])),
		"lastBookingDeltaTime": lastBookingDeltaTime,
		"numPeopleViews": numPeopleViews,
		"propertyListing": propertyListing,
		"inventoryUnitDisplay": inventoryUnitDisplay.toJson(),
		"imageUrl": imageUrl,
		"imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
		"hotelSeoUrl": hotelSeoUrl,
		"extraInfos": List<dynamic>.from(extraInfos.map((x) => x)),
		"hotelInventorySummary": hotelInventorySummary.toJson(),
		"thirdPartyHotelRatingInfoMap": thirdPartyHotelRatingInfoMap.toJson(),
		"loyaltyAmount": loyaltyAmount,
		"hotelLoyaltyDisplay": hotelLoyaltyDisplay.toJson(),
		"accomLoyaltyEligibilityStatus": accomLoyaltyEligibilityStatusValues.reverse[accomLoyaltyEligibilityStatus],
		"accomPropertyType": accomPropertyTypeValues.reverse[accomPropertyType],
		"insiderDisplay": insiderDisplay.toJson(),
		"addOns": addOns,
	};
}

class FeaturedHotelsDisplay {
	dynamic backgroundColor;
	dynamic fontColor;
	dynamic icon;
	dynamic title;
	dynamic subtitle1;
	dynamic subtitle2;
	dynamic subtitle3;
	dynamic type;
	
	FeaturedHotelsDisplay({
		this.backgroundColor,
		this.fontColor,
		this.icon,
		this.title,
		this.subtitle1,
		this.subtitle2,
		this.subtitle3,
		this.type,
	});
	
	factory FeaturedHotelsDisplay.fromJson(Map<String, dynamic> json) => FeaturedHotelsDisplay(
		backgroundColor: json["backgroundColor"],
		fontColor: json["fontColor"],
		icon: json["icon"],
		title: json["title"],
		subtitle1: json["subtitle1"],
		subtitle2: json["subtitle2"],
		subtitle3: json["subtitle3"],
		type: json["type"],
	);
	
	Map<String, dynamic> toJson() => {
		"backgroundColor": backgroundColor,
		"fontColor": fontColor,
		"icon": icon,
		"title": title,
		"subtitle1": subtitle1,
		"subtitle2": subtitle2,
		"subtitle3": subtitle3,
		"type": type,
	};
}

class FilterDisplayInfo {
	List<FilterDisplay> accommodationFilterDisplay;
	List<FilterDisplay> facilityFilterDisplay;
	List<QuickFilterDisplay> quickFilterDisplay;
	List<QuickFilterDisplay> dynamicQuickFilterDisplay;
	
	FilterDisplayInfo({
		this.accommodationFilterDisplay,
		this.facilityFilterDisplay,
		this.quickFilterDisplay,
		this.dynamicQuickFilterDisplay,
	});
	
	factory FilterDisplayInfo.fromJson(Map<String, dynamic> json) => FilterDisplayInfo(
		accommodationFilterDisplay: List<FilterDisplay>.from(json["accommodationFilterDisplay"].map((x) => FilterDisplay.fromJson(x))),
		facilityFilterDisplay: List<FilterDisplay>.from(json["facilityFilterDisplay"].map((x) => FilterDisplay.fromJson(x))),
		quickFilterDisplay: List<QuickFilterDisplay>.from(json["quickFilterDisplay"].map((x) => QuickFilterDisplay.fromJson(x))),
		dynamicQuickFilterDisplay: List<QuickFilterDisplay>.from(json["dynamicQuickFilterDisplay"].map((x) => QuickFilterDisplay.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"accommodationFilterDisplay": List<dynamic>.from(accommodationFilterDisplay.map((x) => x.toJson())),
		"facilityFilterDisplay": List<dynamic>.from(facilityFilterDisplay.map((x) => x.toJson())),
		"quickFilterDisplay": List<dynamic>.from(quickFilterDisplay.map((x) => x.toJson())),
		"dynamicQuickFilterDisplay": List<dynamic>.from(dynamicQuickFilterDisplay.map((x) => x.toJson())),
	};
}

class FilterDisplay {
	String name;
	String displayName;
	bool enabled;
	String count;
	String iconUrlOn;
	String iconUrlOff;
	
	FilterDisplay({
		this.name,
		this.displayName,
		this.enabled,
		this.count,
		this.iconUrlOn,
		this.iconUrlOff,
	});
	
	factory FilterDisplay.fromJson(Map<String, dynamic> json) => FilterDisplay(
		name: json["name"],
		displayName: json["displayName"],
		enabled: json["enabled"],
		count: json["count"],
		iconUrlOn: json["iconUrlOn"] == null ? null : json["iconUrlOn"],
		iconUrlOff: json["iconUrlOff"] == null ? null : json["iconUrlOff"],
	);
	
	Map<String, dynamic> toJson() => {
		"name": name,
		"displayName": displayName,
		"enabled": enabled,
		"count": count,
		"iconUrlOn": iconUrlOn == null ? null : iconUrlOn,
		"iconUrlOff": iconUrlOff == null ? null : iconUrlOff,
	};
}

class QuickFilterDisplay {
	String id;
	String label;
	String description;
	String image;
	bool highlighted;
	String count;
	dynamic backgroundColor;
	dynamic textColor;
	dynamic action;
	
	QuickFilterDisplay({
		this.id,
		this.label,
		this.description,
		this.image,
		this.highlighted,
		this.count,
		this.backgroundColor,
		this.textColor,
		this.action,
	});
	
	factory QuickFilterDisplay.fromJson(Map<String, dynamic> json) => QuickFilterDisplay(
		id: json["id"] == null ? null : json["id"],
		label: json["label"],
		description: json["description"],
		image: json["image"] == null ? null : json["image"],
		highlighted: json["highlighted"],
		count: json["count"],
		backgroundColor: json["backgroundColor"],
		textColor: json["textColor"],
		action: json["action"],
	);
	
	Map<String, dynamic> toJson() => {
		"id": id == null ? null : id,
		"label": label,
		"description": description,
		"image": image == null ? null : image,
		"highlighted": highlighted,
		"count": count,
		"backgroundColor": backgroundColor,
		"textColor": textColor,
		"action": action,
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

class HotelDisplayInfo {
	String finalPriceInfo;
	dynamic finalPriceTooltip;
	
	HotelDisplayInfo({
		this.finalPriceInfo,
		this.finalPriceTooltip,
	});
	
	factory HotelDisplayInfo.fromJson(Map<String, dynamic> json) => HotelDisplayInfo(
		finalPriceInfo: json["finalPriceInfo"],
		finalPriceTooltip: json["finalPriceTooltip"],
	);
	
	Map<String, dynamic> toJson() => {
		"finalPriceInfo": finalPriceInfo,
		"finalPriceTooltip": finalPriceTooltip,
	};
}

class Layout {
	String card;
	
	Layout({
		this.card,
	});
	
	factory Layout.fromJson(Map<String, dynamic> json) => Layout(
		card: json["card"],
	);
	
	Map<String, dynamic> toJson() => {
		"card": card,
	};
}

class SeoInfo {
	String url;
	String title;
	String description;
	
	SeoInfo({
		this.url,
		this.title,
		this.description,
	});
	
	factory SeoInfo.fromJson(Map<String, dynamic> json) => SeoInfo(
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

class VariantContexts {
	String dualNameDisplay;
	
	VariantContexts({
		this.dualNameDisplay,
	});
	
	factory VariantContexts.fromJson(Map<String, dynamic> json) => VariantContexts(
		dualNameDisplay: json["dualNameDisplay"],
	);
	
	Map<String, dynamic> toJson() => {
		"dualNameDisplay": dualNameDisplay,
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
