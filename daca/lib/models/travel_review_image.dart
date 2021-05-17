class TravelReviewImage {
  int id;
  String imageUrl;

  TravelReviewImage({
    this.id,
    this.imageUrl,
  });

  int getId() => this.id;

  String getImageUrl() => this.imageUrl;

  factory TravelReviewImage.fromJson(final json) {
    return TravelReviewImage(
      id: json['id'],
      imageUrl: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'image': this.imageUrl,
    };
  }
}
