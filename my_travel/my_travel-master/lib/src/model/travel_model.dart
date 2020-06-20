class TravelModel {
	int message;
	List<TravelModelDatum> data;
	
	TravelModel({
		this.message,
		this.data,
	});
	
	factory TravelModel.fromJson(Map<String, dynamic> json) => TravelModel(
		message: json["message"],
		data: List<TravelModelDatum>.from(json["data"].map((x) => TravelModelDatum.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"message": message,
		"data": List<dynamic>.from(data.map((x) => x.toJson())),
	};
}

class TravelModelDatum {
	String id;
	String type;
	List<DatumDatum> data;
	
	TravelModelDatum({
		this.id,
		this.type,
		this.data,
	});
	
	factory TravelModelDatum.fromJson(Map<String, dynamic> json) => TravelModelDatum(
		id: json["id"],
		type: json["type"],
		data: List<DatumDatum>.from(json["data"].map((x) => DatumDatum.fromJson(x))),
	);
	
	Map<String, dynamic> toJson() => {
		"id": id,
		"type": type,
		"data": List<dynamic>.from(data.map((x) => x.toJson())),
	};
}

class DatumDatum {
	String id;
	String name;
	List<ImageUrl> imageUrl;
	String content;
	
	DatumDatum({
		this.id,
		this.name,
		this.imageUrl,
		this.content,
	});
	
	factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
		id: json["id"],
		name: json["name"],
		imageUrl: List<ImageUrl>.from(json["imageUrl"].map((x) => ImageUrl.fromJson(x))),
		content: json["content"],
	);
	
	Map<String, dynamic> toJson() => {
		"id": id,
		"name": name,
		"imageUrl": List<dynamic>.from(imageUrl.map((x) => x.toJson())),
		"content": content,
	};
}

class ImageUrl {
	String url;
	
	ImageUrl({
		this.url,
	});
	
	factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
		url: json["url"],
	);
	
	Map<String, dynamic> toJson() => {
		"url": url,
	};
}
