class ProductReviewResponse {
  int success;
  String error;
  List<Review> reviewList;

  ProductReviewResponse({this.success, this.error, this.reviewList});

  ProductReviewResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      reviewList = new List<Review>();
      json['data'].forEach((v) {
        reviewList.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.reviewList != null) {
      data['data'] = this.reviewList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Review {
  String reviewId;
  String title;
  String detail;
  String nickname;
  String createdDateTime;
  int rating;

  Review(
      {this.reviewId,
      this.title,
      this.detail,
      this.nickname,
      this.createdDateTime,
      this.rating});

  Review.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    title = json['title'];
    detail = json['detail'];
    nickname = json['nickname'];
    createdDateTime = json['created_date_time'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['nickname'] = this.nickname;
    data['created_date_time'] = this.createdDateTime;
    data['rating'] = this.rating;
    return data;
  }
}