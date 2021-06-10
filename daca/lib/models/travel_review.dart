import 'package:daca/models/place.dart';
import 'package:daca/models/travel_review_image.dart';
import 'package:daca/public/variables.dart';

class TravelReview {
  static String FOOD_TYPE = DaCaVariables.foodType;
  static String TRAVEL_TYPE = DaCaVariables.travelType;
  static String LIFE_TYPE = DaCaVariables.lifeType;

  int id;
  String title;
  String review;
  String type;
  double rating;
  DateTime date;
  Place place;
  List<TravelReviewImage> images;

  TravelReview({
    this.id,
    this.title,
    this.review,
    this.type,
    this.place,
    this.rating,
    this.date,
    this.images,
  });

  int getId() => this.id;

  String getTitle() => this.title;

  String getReview() => this.review;

  String getType() => this.type;

  Place getPlace() => this.place;

  double getRating() => this.rating;

  List<TravelReviewImage> getImageList() => this.images;

  String getImageByIndex(int position) => this.images[position].getImageUrl();

  void setTitle(String title) => this.title = title;

  void setReview(String review) => this.review = review;

  void setType(String type) => this.type = type;

  void setPlace(Place place) => this.place = place;

  void setRating(double rating) => this.rating = rating;

  void addImage(TravelReviewImage image) => this.images.add(image);

  factory TravelReview.fromJson(final json) {
    return TravelReview(
      id: json[DaCaVariables.reviewIdField],
      place: Place.fromJson(json[DaCaVariables.reviewPlaceDetailsField]),
      title: json[DaCaVariables.reviewTitleField],
      review: json[DaCaVariables.reviewReviewField],
      type: json[DaCaVariables.reviewTypeField],
      rating: json[DaCaVariables.reviewRatingField],
      date: DateTime.parse(json[DaCaVariables.reviewDateField]),
      images: (json[DaCaVariables.reviewImagesField] as List)
          .map((i) => TravelReviewImage.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      DaCaVariables.reviewPlaceIdField: this.place.placeId,
      DaCaVariables.reviewTitleField: this.title,
      DaCaVariables.reviewReviewField: this.review,
      DaCaVariables.reviewTypeField: this.type,
      DaCaVariables.reviewRatingField: this.rating.toString(),
      DaCaVariables.reviewDateField: this.date.toString(),
    };
  }
}
