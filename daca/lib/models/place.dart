import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/src/search/search_result.dart';

class Place extends SearchResult {
  static int count = 0;
  Marker _marker;

  Place(SearchResult searchResult)
      : super(
          geometry: searchResult.geometry,
          businessStatus: searchResult.businessStatus,
          openingHours: searchResult.openingHours,
          photos: searchResult.photos,
          plusCode: searchResult.plusCode,
          formattedAddress: searchResult.formattedAddress,
          name: searchResult.name,
          rating: searchResult.rating,
          icon: searchResult.icon,
          id: searchResult.id,
          placeId: searchResult.placeId,
          priceLevel: searchResult.priceLevel,
          reference: searchResult.reference,
          scope: searchResult.scope,
          types: searchResult.types,
          userRatingsTotal: searchResult.userRatingsTotal,
          vicinity: searchResult.vicinity,
          permanentlyClosed: searchResult.permanentlyClosed,
        ) {
    this._marker = Marker(
        markerId: MarkerId(Place.count.toString()),
        position: LatLng(
          this.geometry.location.lat,
          this.geometry.location.lng,
        ));
    Place.count++;
  }

  Marker get marker => this._marker;

  @override
  bool operator ==(Object other) => other is Place && other.id == this.id;
}
