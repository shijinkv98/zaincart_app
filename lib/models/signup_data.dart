class SignupData {
  String email;
  String firstname;
  String lastname;
  String password;

  SignupData({this.email, this.firstname, this.lastname, this.password});

  SignupData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['password'] = this.password;
    return data;
  }
}