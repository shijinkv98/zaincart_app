import 'package:flutter/material.dart';
import 'package:zaincart_app/models/address.dart';
import 'package:zaincart_app/models/addressListResponse.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';

class ProfileBloc extends ChangeNotifier {
  List<Address> addressList = new List<Address>();
  bool isLoading = false;

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
}