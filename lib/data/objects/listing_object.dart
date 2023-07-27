// To parse this JSON data, do
//
// final listings = listingsFromJson(jsonString);

import 'dart:convert';

Listings listingsFromJson(String str) => Listings.fromJson(json.decode(str));

String listingsToJson(Listings data) => json.encode(data.toJson());

class Listings {
  List<Listing> listings;

  Listings({
    required this.listings,
  });

  factory Listings.fromJson(Map<String, dynamic> json) => Listings(
        listings: List<Listing>.from(json['listings'].map((x) => Listing.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'listings': List<dynamic>.from(listings.map((x) => x.toJson())),
      };
}

class Listing {
  String id;
  String deviceCondition;
  String listedBy;
  String deviceStorage;
  List<ListingImage> images;
  ListingImage defaultImage;
  String listingLocation;
  String make;
  String marketingName;
  String mobileNumber;
  String model;
  bool verified;
  String status;
  String listingDate;
  String deviceRam;
  String createdAt;
  String listingId;
  int listingNumPrice;
  String listingState;

  Listing({
    required this.id,
    required this.deviceCondition,
    required this.listedBy,
    required this.deviceStorage,
    required this.images,
    required this.defaultImage,
    required this.listingLocation,
    required this.make,
    required this.marketingName,
    required this.mobileNumber,
    required this.model,
    required this.verified,
    required this.status,
    required this.listingDate,
    required this.deviceRam,
    required this.createdAt,
    required this.listingId,
    required this.listingNumPrice,
    required this.listingState,
  });

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
        id: json["_id"],
        deviceCondition: json["deviceCondition"],
        listedBy: json["listedBy"],
        deviceStorage: json["deviceStorage"],
        images: List<ListingImage>.from(json["images"].map((x) => ListingImage.fromJson(x))),
        defaultImage: ListingImage.fromJson(json["defaultImage"]),
        listingLocation: json["listingLocation"],
        make: json["make"],
        marketingName: json["marketingName"],
        mobileNumber: json["mobileNumber"],
        model: json["model"],
        verified: json["verified"],
        status: json["status"],
        listingDate: json["listingDate"],
        deviceRam: json["deviceRam"],
        createdAt: json["createdAt"],
        listingId: json["listingId"],
        listingNumPrice: json["listingNumPrice"],
        listingState: json["listingState"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "deviceCondition": deviceCondition,
        "listedBy": listedBy,
        "deviceStorage": deviceStorage,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "defaultImage": defaultImage.toJson(),
        "listingLocation": listingLocation,
        "make": make,
        "marketingName": marketingName,
        "mobileNumber": mobileNumber,
        "model": model,
        "verified": verified,
        "status": status,
        "listingDate": listingDate,
        "deviceRam": deviceRam,
        "createdAt": createdAt,
        "listingId": listingId,
        "listingNumPrice": listingNumPrice,
        "listingState": listingState,
      };
}

class ListingImage {
  String fullImage;

  ListingImage({
    required this.fullImage,
  });

  factory ListingImage.fromJson(Map<String, dynamic> json) => ListingImage(
        fullImage: json["fullImage"],
      );

  Map<String, dynamic> toJson() => {
        "fullImage": fullImage,
      };
}
