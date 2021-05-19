import 'package:daca/models/place.dart';
import 'package:daca/models/travel_review_image.dart';

class TravelReview {
  int id;
  String title;
  String review;
  double rating;
  DateTime date;
  Place place;
  List<TravelReviewImage> images;

  TravelReview({
    this.id,
    this.title,
    this.review,
    this.place,
    this.rating,
    this.date,
    this.images,
  });

  TravelReview.defaultReview() {
    this.id = null;
    this.title = "";
    this.review = "";
    this.place = null;
    this.rating = 2.5;
    this.images = [];
    this.date = DateTime.now();
  }

  int getId() => this.id;

  String getTitle() => this.title;

  String getReview() => this.review;

  Place getPlace() => this.place;

  double getRating() => this.rating;

  List<TravelReviewImage> getImageList() => this.images;

  String getImageByIndex(int position) => this.images[position].getImageUrl();

  void setTitle(String title) => this.title = title;

  void setReview(String review) => this.review = review;

  void setPlace(Place place) => this.place = place;

  void setRating(double rating) => this.rating = rating;

  void addImage(TravelReviewImage image) => this.images.add(image);

  factory TravelReview.fromJson(final json) {
    return TravelReview(
      id: json['id'],
      place: Place.fromJson(json['place_details']),
      title: json['title'],
      review: json['review'],
      rating: json['rating'],
      date: DateTime.parse(json['date']),
      images: (json['images'] as List)
          .map((i) => TravelReviewImage.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': this.place.placeId,
      'title': this.title,
      'review': this.review,
      'rating': this.rating.toString(),
      'date': this.date.toString(),
    };
  }
}
