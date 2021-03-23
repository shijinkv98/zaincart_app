class ContactDetailsResponse {
  int success;
  String error;
  ContactDetail contactDetail;

  ContactDetailsResponse({this.success, this.error, this.contactDetail});

  ContactDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    contactDetail = json['data'] != null ? new ContactDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.contactDetail != null) {
      data['data'] = this.contactDetail.toJson();
    }
    return data;
  }
}

class ContactDetail {
  Details details;

  ContactDetail({this.details});

  ContactDetail.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    return data;
  }
}

class Details {
  String phone;
  String mobile;
  String mail;
  String address;
  String workingtime;
  String latitude;
  String longitude;

  Details(
      {this.phone,
      this.mobile,
      this.mail,
      this.address,
      this.workingtime,
      this.latitude,
      this.longitude});

  Details.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    mobile = json['mobile'];
    mail = json['mail'];
    address = json['address'];
    workingtime = json['workingtime'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['mail'] = this.mail;
    data['address'] = this.address;
    data['workingtime'] = this.workingtime;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}