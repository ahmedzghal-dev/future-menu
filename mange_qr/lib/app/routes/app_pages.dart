import 'package:get/get.dart';
import '../../core/constants/constants.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/onboarding/bindings/onboarding_binding.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/auth/bindings/auth_binding.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/home/bindings/home_binding.dart';
import '../../presentation/screens/details/details_screen.dart';
import '../../presentation/screens/details/bindings/details_binding.dart';
import '../../presentation/screens/scanner/scanner_screen.dart';
import '../../presentation/screens/scanner/bindings/scanner_binding.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/profile/bindings/profile_binding.dart';

class AppPages {
  static const INITIAL = AppConstants.splashRoute;

  static final routes = [
    GetPage(
      name: AppConstants.initialRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppConstants.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppConstants.onboardingRoute,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppConstants.authRoute,
      page: () => const AuthScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppConstants.homeRoute,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppConstants.detailsRoute,
      page: () => const DetailsScreen(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: AppConstants.scannerRoute,
      page: () => const ScannerScreen(),
      binding: ScannerBinding(),
    ),
    GetPage(
      name: AppConstants.profileRoute,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
