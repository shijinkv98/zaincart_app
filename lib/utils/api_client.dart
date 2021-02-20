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
    return Base_URL +
        "wishlisitems?customer_id=$customerId&customertoken=$token";
  }

  static final mycartList = Base_URL + "cartdisplay";
  static final wishListAdd = Base_URL + "wishlistadd";
  static final addToCart = Base_URL + "customercart";
  static final wishlistRemove = Base_URL + "wishlistitemremove";
  static final removeFromCart = Base_URL + "deletecustomercartitem";
  static final addressList = Base_URL + "loadaddress";
  static final addAddress = Base_URL + "customeraddressadd";
  static final addressUpdate = Base_URL + "updateaddress";
  static final placeOrder = Base_URL + "createorder";
}
