class ReviewModel {
  final int rating;
  final String comment;
  final String reviewerName;

  ReviewModel({
    required this.rating,
    required this.comment,
    required this.reviewerName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json["rating"],
      comment: json["comment"],
      reviewerName: json["reviewerName"],
    );
  }
}
