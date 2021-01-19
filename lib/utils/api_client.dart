class APIClient {
  static final Base_URL = "http://139.59.47.221/zain/rest/V1/";

  static final signup = Base_URL + "customerreg";
  static final login = Base_URL + "customerlogin";
  static homeData(String id) {
    return Base_URL + "homepage?Customer_id=$id";
  }
  
}
