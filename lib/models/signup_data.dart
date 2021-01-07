class SignupData {
  String firstName;
  String lastName;
  String email;
  String city;
  String address1;
  String state;
  String country;
  String password;
  String mobilecountrycode;
  String mobileareacode;
  String mobileNumber;
  String phone;
  int otpauth;
  String roles;

  SignupData(
      {this.firstName,
      this.lastName,
      this.email,
      this.city,
      this.address1,
      this.state,
      this.country,
      this.password,
      this.mobilecountrycode,
      this.mobileareacode,
      this.mobileNumber,
      this.phone,
      this.otpauth,
      this.roles});

  SignupData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    city = json['city'];
    address1 = json['address1'];
    state = json['state'];
    country = json['country'];
    password = json['password'];
    mobilecountrycode = json['mobilecountrycode'];
    mobileareacode = json['mobileareacode'];
    mobileNumber = json['mobilenumber'];
    phone = json['phone'];
    otpauth = json['otpauth'];
    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['city'] = this.city;
    data['address1'] = this.address1;
    data['state'] = this.state;
    data['country'] = this.country;
    data['password'] = this.password;
    data['mobilecountrycode'] = this.mobilecountrycode;
    data['mobileareacode'] = this.mobileareacode;
    data['mobilenumber'] = this.mobileNumber;
    data['phone'] = this.phone;
    data['otpauth'] = this.otpauth;
    data['roles'] = this.roles;
    return data;
  }
}
