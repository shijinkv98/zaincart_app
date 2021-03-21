class ProductReviewResponse {
  int success;
  String error;
  ReviewData reviewData;

  ProductReviewResponse({this.success, this.error, this.reviewData});

  ProductReviewResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    reviewData = json['data'] != null ? new ReviewData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.reviewData != null) {
      data['data'] = this.reviewData.toJson();
    }
    return data;
  }
}

class ReviewData {
  int rating;
  List<Review> list;

  ReviewData({this.rating, this.list});

  ReviewData.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    if (json['list'] != null) {
      list = new List<Review>();
      json['list'].forEach((v) {
        list.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
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