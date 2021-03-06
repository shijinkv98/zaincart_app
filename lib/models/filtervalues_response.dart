class FilterValueResponse {
  int success;
  String error;
  List<FilterData> filterValues;

  FilterValueResponse({this.success, this.error, this.filterValues});

  FilterValueResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      filterValues = new List<FilterData>();
      json['data'].forEach((v) {
        filterValues.add(new FilterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.filterValues != null) {
      data['data'] = this.filterValues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterData {
  String key;
  String code;
  List<Values> values;
  double minPrice;
  int maxPrice;

  FilterData({this.key, this.code, this.values, this.minPrice, this.maxPrice});

  FilterData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    code = json['code'];
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
    minPrice = json['min-price'];
    maxPrice = json['max-price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['code'] = this.code;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    data['min-price'] = this.minPrice;
    data['max-price'] = this.maxPrice;
    return data;
  }
}

class Values {
  String label;
  String value;
  String count;

  Values({this.label, this.value, this.count});

  Values.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['count'] = this.count;
    return data;
  }
}

class FilterInput {
  String customerId;
  String pageNo;
  String customertoken;
  String category;
  List<FilterVal> filterVal;

  FilterInput(
      {this.customerId,
      this.pageNo,
      this.customertoken,
      this.category,
      this.filterVal});

  FilterInput.fromJson(Map<String, dynamic> json) {
    customerId = json['Customer_id'];
    pageNo = json['page_no'];
    customertoken = json['customertoken'];
    category = json['category'];
    if (json['filter_val'] != null) {
      filterVal = new List<FilterVal>();
      json['filter_val'].forEach((v) {
        filterVal.add(new FilterVal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Customer_id'] = this.customerId;
    data['page_no'] = this.pageNo;
    data['customertoken'] = this.customertoken;
    data['category'] = this.category;
    if (this.filterVal != null) {
      data['filter_val'] = this.filterVal.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterVal {
  String key;
  List<String> values;

  FilterVal({this.key, this.values});

  FilterVal.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    values = json['values'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['values'] = this.values;
    return data;
  }
}