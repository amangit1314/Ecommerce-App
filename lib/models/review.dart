import 'dart:convert';

class Review {
  final String rid;
  final String comment;
  final int stars;
  final String reviewerName;
  final String when;

  Review(
    this.rid, {
    required this.comment,
    required this.stars,
    required this.reviewerName,
    required this.when,
  });

  Map<String, dynamic> toMap() {
    return {
      'rid': rid,
      'comment': comment,
      'stars': stars,
      'reviewerName': reviewerName,
      'when': when,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      map['rid'] ?? '',
      comment: map['comment'] ?? '',
      stars: map['stars']?.toInt() ?? 0,
      reviewerName: map['reviewerName'] ?? '',
      when: map['when'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));
}
