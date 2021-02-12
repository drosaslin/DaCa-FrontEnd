class TravelReview {
  int id;
  String title;
  String review;
  String placeId;
  double rating;
  DateTime date;

  TravelReview({
    this.id,
    this.title,
    this.review,
    this.placeId,
    this.rating,
    this.date,
  });

  TravelReview.defaultReview() {
    this.id = null;
    this.title = "";
    this.review = "";
    this.placeId = "";
    this.rating = 2.5;
    this.date = DateTime.now();
  }

  String getTitle() {
    return this.title;
  }

  void setTitle(String title) {
    this.title = title;
  }

  String getReview() {
    return this.review;
  }

  void setReview(String review) {
    this.review = review;
  }

  String getPlaceId() {
    return this.placeId;
  }

  void setPlaceId(String id) {
    this.placeId = id;
  }

  double getRating() {
    return this.rating;
  }

  void setRating(double rating) {
    this.rating = rating;
  }

  factory TravelReview.fromJson(final json) {
    return TravelReview(
      id: json['id'],
      placeId: json['place_id'],
      title: json['title'],
      review: json['review'],
      rating: json['rating'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'place_id': this.placeId,
        'title': this.title,
        'review': this.review,
        'rating': this.rating.toString(),
        'date': this.date.toString(),
      };
}
