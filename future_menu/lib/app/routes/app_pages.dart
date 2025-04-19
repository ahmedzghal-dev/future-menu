import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/email_verification/bindings/email_verification_binding.dart';
import '../modules/email_verification/views/email_verification_view.dart';
import '../modules/create_account/bindings/create_account_binding.dart';
import '../modules/create_account/views/create_account_view.dart';
import '../modules/verify_code/bindings/verify_code_binding.dart';
import '../modules/verify_code/views/verify_code_view.dart';
import '../modules/location/bindings/location_binding.dart';
import '../modules/location/views/location_view.dart';
import '../modules/location/views/location_qr_view.dart';
import '../modules/location/views/location_manual_view.dart';
import '../modules/restaurants/bindings/restaurants_binding.dart';
import '../modules/restaurants/views/restaurants_view.dart';
import '../modules/virtual_assistant/bindings/virtual_assistant_binding.dart';
import '../modules/virtual_assistant/views/virtual_assistant_view.dart';
import '../modules/menu/bindings/menu_binding.dart';
import '../modules/menu/views/menu_filter_view.dart';
import '../modules/menu/views/menu_view.dart';
import '../modules/menu/views/food_detail_view.dart';
import '../modules/recommendation/bindings/recommendation_binding.dart';
import '../modules/recommendation/views/recommendation_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_status_view.dart';
import '../modules/order/views/checkout_view.dart';
import '../modules/order/views/add_card_view.dart';
import '../modules/order/views/payment_success_view.dart';
import '../modules/order/views/feedback_view.dart';
import '../modules/rewards/bindings/rewards_binding.dart';
import '../modules/rewards/views/rewards_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () {
        debugPrint('Creating SplashView');
        return const SplashView();
      },
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () {
        debugPrint('Creating OnboardingView');
        return const OnboardingView();
      },
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.AUTHENTICATION,
      page: () => AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: Routes.EMAIL_VERIFICATION,
      page: () => EmailVerificationView(),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: Routes.CREATE_ACCOUNT,
      page: () => CreateAccountView(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: Routes.VERIFY_CODE,
      page: () => VerifyCodeView(),
      binding: VerifyCodeBinding(),
    ),
    GetPage(
      name: Routes.LOCATION,
      page: () => LocationView(),
      binding: LocationBinding(),
      children: [
        GetPage(name: '/qr', page: () => LocationQrView()),
        GetPage(name: '/manual', page: () => LocationManualView()),
      ],
    ),
    GetPage(
      name: Routes.RESTAURANTS,
      page: () => RestaurantsView(),
      binding: RestaurantsBinding(),
    ),
    GetPage(
      name: Routes.VIRTUAL_ASSISTANT,
      page: () => VirtualAssistantView(),
      binding: VirtualAssistantBinding(),
    ),
    GetPage(
      name: Routes.MENU,
      page: () => const MenuView(),
      binding: MenuBinding(),
      children: [
        GetPage(
          name: _Paths.FILTER,
          page: () => const MenuFilterView(),
          binding: MenuBinding(),
        ),
      ],
    ),
    GetPage(
      name: Routes.FOOD_DETAIL,
      page: () => const FoodDetailView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: Routes.RECOMMENDATION,
      page: () => const RecommendationView(),
      binding: RecommendationBinding(),
    ),
    GetPage(
      name: Routes.REWARDS,
      page: () => const RewardsView(),
      binding: RewardsBinding(),
    ),
    GetPage(name: Routes.CART, page: () => CartView(), binding: CartBinding()),
    GetPage(
      name: Routes.ORDER_STATUS,
      page: () => OrderStatusView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.CHECKOUT,
      page: () => CheckoutView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.ADD_CARD,
      page: () => AddCardView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_SUCCESS,
      page: () => PaymentSuccessView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.FEEDBACK,
      page: () => FeedbackView(),
      binding: OrderBinding(),
    ),
  ];
}
