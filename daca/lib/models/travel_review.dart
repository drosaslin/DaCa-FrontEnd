import 'package:daca/models/place.dart';

class TravelReview {
  int id;
  String title;
  String review;
  double rating;
  DateTime date;
  Place place;

  TravelReview({
    this.id,
    this.title,
    this.review,
    this.place,
    this.rating,
    this.date,
  });

  TravelReview.defaultReview() {
    this.id = null;
    this.title = "";
    this.review = "";
    this.place = null;
    this.rating = 2.5;
    this.date = DateTime.now();
  }

  String getTitle() => this.title;

  String getReview() => this.review;

  Place getPlace() => this.place;

  double getRating() => this.rating;

  void setTitle(String title) => this.title = title;

  void setReview(String review) => this.review = review;

  void setPlace(Place place) => this.place = place;

  void setRating(double rating) => this.rating = rating;

  factory TravelReview.fromJson(final json) {
    return TravelReview(
      id: json['id'],
      place: Place.fromJson(json['place_details']),
      title: json['title'],
      review: json['review'],
      rating: json['rating'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': this.place.placeId,
      'place_details': this.place.toJson(),
      'title': this.title,
      'review': this.review,
      'rating': this.rating.toString(),
      'date': this.date.toString(),
    };
  }
}
