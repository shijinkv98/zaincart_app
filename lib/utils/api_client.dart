class APIClient {
  static final Base_URL = "http://zaincart.com/rest/V1/";

  static final signup = Base_URL + "customerreg";
  static final login = Base_URL + "customerlogin";
  static homeData(String id) {
    return Base_URL + "homepage?Customer_id=$id";
  }
  static productDetail({String productId, String customerId}) {
    return Base_URL + "productdetails/$productId?Customer_id=$customerId";
  }

  static wishlist({String token, String customerId}) {
    return Base_URL + "wishlisitems?customer_id=$customerId&customertoken=$token";
  }
}
