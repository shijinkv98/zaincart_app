class APIClient {
  static final Base_URL = "https://zaincart.com/rest/V1/";

  static final signup = Base_URL + "customerreg";
  static final login = Base_URL + "customerlogin";
  static final bearerToken = Base_URL + "accesstoken";
  static final forgotPassword = Base_URL + "passwordforgot";
  static final resetPassword = Base_URL + "passwordreset";
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
  static final rootCategories = Base_URL + "rootcategories";
  static productsByCategory({String categoryId, String pageNo}) {
    return Base_URL + "productsbycategory/$categoryId/$pageNo";
  }

  static final updateCart = Base_URL + "updateitemscart";
  static final myOrder = Base_URL + "myorder";
  static final myOrderDetail = Base_URL + "myorderdetail";
  static final getAbout = Base_URL + "getabout";
  static final getTermsAndCondition = Base_URL + "getermsandcondition";
  static final getPolicy = Base_URL + "getpolicy";
  static final changePassword = Base_URL + "passwordchange";
  static final productSearch = Base_URL + "productsearch";
  static cancelOrder(String orderId) {
    return Base_URL + "orders/$orderId/cancel";
  }

  static final contactDetails = Base_URL + "contactdetails";
  static final deleteAddresses = Base_URL + "deleteaddresses";
  static final setDefaultAddress = Base_URL + "setdefalutaddress";
  static filterValues(String categoryId) {
    return Base_URL + "filtervalues/$categoryId";
  }

  static final filterProducts = Base_URL + "getfilterproducts";

  static final updateProfile = Base_URL + "updateprofile";
  static final logout = Base_URL + "customerlogout";
  static final countries = Base_URL + "countrylist";
  static final addReview = Base_URL + "Addreviewproduct";
  static final getReviews = Base_URL + "productreview";
  static final notificationList = Base_URL + "notificationlist";
  static final checkoutDetails = Base_URL + "checkoutdetails";
  static final contactus = Base_URL + "contactus";
  static final buynow = Base_URL + "buynow";
  static final reorder = Base_URL + "reorder";
  static sortProducts(String pageNo) {
    return Base_URL + "sortproducts/$pageNo";
  }
}
