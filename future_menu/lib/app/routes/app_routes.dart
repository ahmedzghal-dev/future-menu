part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const AUTHENTICATION = '/authentication';
  static const EMAIL_VERIFICATION = '/email-verification';
  static const CREATE_ACCOUNT = '/create-account';
  static const VERIFY_CODE = '/verify-code';
  static const LOCATION = '/location';
  static const LOCATION_QR = '/location/qr';
  static const LOCATION_MANUAL = '/location/manual';
  static const RESTAURANTS = '/restaurants';
  static const VIRTUAL_ASSISTANT = '/virtual-assistant';
  static const MENU = '/menu';
  static const FOOD_DETAIL = '/food-detail';
  static const PROFILE = '/profile';
  static const RECOMMENDATION = '/recommendation';
  static const REWARDS = '/rewards';
  static const CART = '/cart';
  static const ORDER_STATUS = '/order-status';
  static const CHECKOUT = '/checkout';
  static const ADD_CARD = '/add-card';
  static const PAYMENT_SUCCESS = '/payment-success';
  static const FEEDBACK = '/feedback';
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const FILTER = '/filter';
} 