class CountriesResponse {
  int success;
  String error;
  List<Country> countryList;

  CountriesResponse({this.success, this.error, this.countryList});

  CountriesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      countryList = new List<Country>();
      json['data'].forEach((v) {
        countryList.add(new Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.countryList != null) {
      data['data'] = this.countryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  String countryCode;
  String countryName;

  Country({this.countryCode, this.countryName});

  Country.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['country_name'] = this.countryName;
    return data;
  }
}