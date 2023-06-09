import 'package:intl/intl.dart';

class AppConfigs {
  static const String URL_BaseAPI = "https://192.168.1.185";
  static const String URL_UserRouteAPI = URL_BaseAPI + "/api/Users";
  static const String URL_CategoryRouteAPI = URL_BaseAPI + "/api/Category";
  static const String URL_FoodRouteAPI = URL_BaseAPI + "/api/Food";
  static const String URL_RatingsRouteAPI = URL_BaseAPI + "/api/Ratings";
  static const String URL_CartsRouteAPI = URL_BaseAPI + "/api/Carts";
  static const String URL_AddressesRouteAPI = URL_BaseAPI + "/api/Addresses";
  static const String URL_OrdersRouteAPI = URL_BaseAPI + "/api/Orders";
  static const String URL_NotificationsRouteAPI =
      URL_BaseAPI + "/api/Notifications";
  static const String URL_PromotionsRouteAPI = URL_BaseAPI + "/api/Promotions";
  static const String URL_SaleCampaignsRouteAPI =
      URL_BaseAPI + "/api/SaleCampaigns";

  static const String URL_Images = URL_BaseAPI + "/user-content";

  static final NumberFormat _appNumberFormat = NumberFormat();
  static final DateFormat AppDateFormat = DateFormat('yyyy-MM-dd');
  static String toPrice(double price) {
    return _appNumberFormat.format(price) + "đ";
  }
}
