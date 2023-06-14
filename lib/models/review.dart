import 'dart:convert';

class Review {
  final String comment;
  final double stars;
  final String reviewerName;
  final String when;
  final bool isRecommend;
  final String reviewerPic;

  Review({
    required this.comment,
    required this.stars,
    required this.reviewerName,
    required this.when,
    required this.isRecommend,
    required this.reviewerPic,
  });

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'stars': stars,
      'reviewerName': reviewerName,
      'when': when,
      'isRecommend': isRecommend,
      'reviewerPic': reviewerPic,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      comment: map['comment'] ?? '',
      stars: (map['stars'] as num?)?.toDouble() ?? 0,
      reviewerName: map['reviewerName'] ?? '',
      when: map['when'] ?? '',
      isRecommend: map['isRecommend'] ?? false,
      reviewerPic: map['reviewerPic'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));
}
