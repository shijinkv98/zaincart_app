class Address {
    String addressId;
  String customerId;
  String firstname;
  String lastname;
  String postcode;
  String city;
  String state;
  String telephone;
  String countryId;
  String street;
  int defaultbilling;
  int defaultshipping;
  String saveinaddressbook;
  String customertoken;

  Address(
      {this.addressId,this.customerId,
      this.firstname,
      this.lastname,
      this.postcode,
      this.city,
      this.state,
      this.telephone,
      this.countryId,
      this.street,
      this.defaultbilling,
      this.defaultshipping,
      this.saveinaddressbook,
      this.customertoken});

  Address.fromJson(Map<String, dynamic> json) {
    addressId = json['addressid'];
    customerId = json['customer_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    postcode = json['postcode'];
    city = json['city'];
    state = json['state'];
    telephone = json['telephone'];
    countryId = json['countryid'];
    street = json['street'];
    defaultbilling = json['defaultbilling'];
    defaultshipping = json['defaultshipping'];
    saveinaddressbook = json['saveinaddressbook'];
    customertoken = json['customertoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressid'] = this.addressId;
    data['customer_id'] = this.customerId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['telephone'] = this.telephone;
    data['countryid'] = this.countryId;
    data['street'] = this.street;
    data['defaultbilling'] = this.defaultbilling;
    data['defaultshipping'] = this.defaultshipping;
    data['saveinaddressbook'] = this.saveinaddressbook;
    data['customertoken'] = this.customertoken;
    return data;
  }
}