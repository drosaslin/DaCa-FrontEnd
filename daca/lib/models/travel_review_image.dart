import 'package:daca/public/variables.dart';

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
      id: json[DaCaVariables.imageIdField],
      imageUrl: json[DaCaVariables.imageField],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      DaCaVariables.imageIdField: this.id,
      DaCaVariables.imageField: this.imageUrl,
    };
  }
}
