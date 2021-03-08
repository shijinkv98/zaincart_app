class NotificationResponse {
  int success;
  String error;
  Data data;

  NotificationResponse({this.success, this.error, this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int cartCount;
  int wishCount;
  List<NotificationData> notification;

  Data({this.cartCount, this.wishCount, this.notification});

  Data.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
    wishCount = json['wish_count'];
    if (json['notification'] != null) {
      notification = new List<NotificationData>();
      json['notification'].forEach((v) {
        notification.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_count'] = this.cartCount;
    data['wish_count'] = this.wishCount;
    if (this.notification != null) {
      data['notification'] = this.notification.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String link;
  String type;
  String title;
  String notificationId;
  String content;
  String image;
  String createdAt;

  NotificationData(
      {this.link,
      this.type,
      this.title,
      this.notificationId,
      this.content,
      this.image,
      this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    type = json['type'];
    title = json['title'];
    notificationId = json['notification_id'];
    content = json['content'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['type'] = this.type;
    data['title'] = this.title;
    data['notification_id'] = this.notificationId;
    data['content'] = this.content;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}