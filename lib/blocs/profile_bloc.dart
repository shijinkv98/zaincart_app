import 'package:flutter/material.dart';
import 'package:zaincart_app/models/address.dart';
import 'package:zaincart_app/models/addressListResponse.dart';
import 'package:zaincart_app/models/checkout_detail_response.dart';
import 'package:zaincart_app/models/countries_response.dart';
import 'package:zaincart_app/models/notification_response.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/models/wishlistAddResponse.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';

class ProfileBloc extends ChangeNotifier {
  List<Address> addressList = new List<Address>();
  List<Country> countryList = new List<Country>();
  List<NotificationData> notificationList = new List<NotificationData>();
  CheckoutData checkoutData;
  bool isLoading = false;
  var firstName;
  var lastName;
  var email;
  var phone;
  var isGuest;

  void getUserInfo() async {
    firstName = await Preferences.get(PrefKey.firstName);
    lastName = await Preferences.get(PrefKey.lastName);
    email = await Preferences.get(PrefKey.email);
    phone = await Preferences.get(PrefKey.mobileNumber);
    isGuest = await Preferences.getBool(PrefKey.loginStatus);
    notifyListeners();
  }

  getAddressList(BuildContext context) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().addressList().then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            AddressListResponse addressResponse =
                AddressListResponse.fromJson(response.data);
            if (addressResponse.success == 1) {
              addressList = addressResponse.data.addressList;
              notifyListeners();
            } else if (addressResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(addressResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  deleteAddress(BuildContext context, String addressId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().deleteAddress(addressId).then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            ZCResponse addressResponse = ZCResponse.fromJson(response.data);
            if (addressResponse.success == 1) {
              AlertUtils.showToast("Deleted successfully", context);
              getAddressList(context);
            } else if (addressResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(addressResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  defaultAddress(BuildContext context, String addressId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().setDefaultAddress(addressId).then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            ZCResponse addressResponse = ZCResponse.fromJson(response.data);
            if (addressResponse.success == 1) {
              AlertUtils.showToast(
                  "Default address added successfully", context);
              getAddressList(context);
            } else if (addressResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(addressResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  addAddress(BuildContext context, Address _address) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().addAddress(_address).then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            ZCResponse addressResponse = ZCResponse.fromJson(response.data);
            if (addressResponse.success == 1) {
              AlertUtils.showToast("Address successfully added", context);
              getAddressList(context);
              Navigator.of(context).pop();
            } else if (addressResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(addressResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  updateAddress(BuildContext context, Address _address) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().addressUpdate(_address).then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            ZCResponse addressResponse = ZCResponse.fromJson(response.data);
            if (addressResponse.success == 1) {
              AlertUtils.showToast("Address successfully updated", context);
              getAddressList(context);
              Navigator.of(context).pop();
            } else if (addressResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(addressResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  updateProfile(
      {BuildContext context, String email, String firstName, String lastName}) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService()
            .updateProfile(
                email: email, firstName: firstName, lastName: lastName)
            .then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            ZCResponse addressResponse = ZCResponse.fromJson(response.data);
            if (addressResponse.success == 1) {
              AlertUtils.showToast("Profile successfully added", context);
              Preferences.save(PrefKey.firstName, firstName);
              Preferences.save(PrefKey.lastName, lastName);
              Preferences.save(PrefKey.email, email);
              getUserInfo();
              Navigator.of(context).pop();
            } else if (addressResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(addressResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  logout(BuildContext context) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().logout().then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            ZCResponse addressResponse = ZCResponse.fromJson(response.data);
            if (addressResponse.success == 1) {
              AlertUtils.showToast("You have sucessfully logged out", context);
              Preferences.clearPreference();
            } else if (addressResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(addressResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  getCountries(BuildContext context) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().getCountries(context).then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            CountriesResponse countriesResponse =
                CountriesResponse.fromJson(response.data);
            if (countriesResponse.success == 1) {
              countryList = countriesResponse.countryList;
              notifyListeners();
            } else if (countriesResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(countriesResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  addReview(
      {BuildContext context,
      String produtId,
      double rating,
      String title,
      String detail}) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService()
            .addReview(
                produtId: produtId,
                rating: rating,
                title: title,
                detail: detail)
            .then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            WishlistAddResponse addReviewResponse =
                WishlistAddResponse.fromJson(response.data);
            if (addReviewResponse.success == 1) {
              AlertUtils.showToast(addReviewResponse.data.message, context);
              Navigator.of(context).pop();
            } else if (addReviewResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(addReviewResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  getNotificationList(BuildContext context) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().notificationList().then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            NotificationResponse notificationResponse =
                NotificationResponse.fromJson(response.data);
            if (notificationResponse.success == 1) {
              notificationList = notificationResponse.data.notification;
              notifyListeners();
            } else if (notificationResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(notificationResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  getCheckoutDetails(BuildContext context) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().getCheckoutDetails(context).then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            CheckoutDetailsResponse checkoutDetailResponse =
                CheckoutDetailsResponse.fromJson(response.data);
            if (checkoutDetailResponse.success == 1) {
              checkoutData = checkoutDetailResponse.checkoutData;
              notifyListeners();
            } else if (checkoutDetailResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(checkoutDetailResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  contactUs(
      {BuildContext context, String email, String name, String phone, String message}) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService()
            .contactUs(
                email: email, name: name, phone: phone, message: message)
            .then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            WishlistAddResponse feedbackResponse = WishlistAddResponse.fromJson(response.data);
            if (feedbackResponse.success == 1) {
              AlertUtils.showToast(feedbackResponse.data.message, context);
              Navigator.of(context).pop();
            } else if (feedbackResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(feedbackResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }
}
