import 'photos.dart';
import 'geometry.dart';
import 'opening_hours.dart';
import 'plus_code.dart';

class Place {
  String businessStatus;
  String formattedAddress;
  Geometry geometry;
  String icon;
  String name;
  OpeningHours openingHours;
  List<Photos> photos;
  String placeId;
  PlusCode plusCode;
  int priceLevel;
  num rating;
  String reference;
  String scope;
  List<String> types;
  int userRatingsTotal;
  String vicinity;

  Place(
      {this.businessStatus,
      this.formattedAddress,
      this.geometry,
      this.icon,
      this.name,
      this.openingHours,
      this.photos,
      this.placeId,
      this.plusCode,
      this.priceLevel,
      this.rating,
      this.reference,
      this.scope,
      this.types,
      this.userRatingsTotal,
      this.vicinity});

  Place.fromJson(Map<String, dynamic> json) {
    businessStatus = json['business_status'];
    formattedAddress = json['formatted_address'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    icon = json['icon'];
    name = json['name'];
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos.add(Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    plusCode =
        json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    priceLevel = json['price_level'];
    rating = json['rating'];
    reference = json['reference'];
    scope = json['scope'];
    types = json['types'].cast<String>();
    userRatingsTotal = json['user_ratings_total'];
    vicinity = json['vicinity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['business_status'] = this.businessStatus;
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    data['icon'] = this.icon;
    data['name'] = this.name;
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['place_id'] = this.placeId;
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode.toJson();
    }
    data['price_level'] = this.priceLevel;
    data['rating'] = this.rating;
    data['reference'] = this.reference;
    data['scope'] = this.scope;
    data['types'] = this.types;
    data['user_ratings_total'] = this.userRatingsTotal;
    data['vicinity'] = this.vicinity;
    return data;
  }
}
