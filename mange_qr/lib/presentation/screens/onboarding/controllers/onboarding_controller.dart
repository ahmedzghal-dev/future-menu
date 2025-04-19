import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/constants.dart';

class OnboardingController extends GetxController {
  late PageController pageController;
  final RxInt currentPage = 0.obs;
  late SharedPreferences _prefs;
  
  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Find Restaurants Near You',
      'description': 'Discover the best restaurants and food options nearby with just a few taps.',
      'image': 'assets/images/onboarding1.png'
    },
    {
      'title': 'Scan QR Code Menu',
      'description': 'Scan restaurant QR codes to instantly view their digital menu without downloading multiple apps.',
      'image': 'assets/images/onboarding2.png'
    },
    {
      'title': 'Order Food Easily',
      'description': 'Browse menus, customize orders, and pay seamlessly all in one place.',
      'image': 'assets/images/onboarding3.png'
    }
  ];
  
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _initPrefs();
  }
  
  Future<void> _initPrefs() async {
    try {
      _prefs = Get.find<SharedPreferences>();
    } catch (e) {
      _prefs = await SharedPreferences.getInstance();
      Get.put(_prefs);
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      completeOnboarding();
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  void completeOnboarding() async {
    try {
      await _prefs.setBool(AppConstants.onboardingCompleteKey, true);
    } catch (e) {
      debugPrint('Error saving onboarding status: $e');
    }
    Get.offAllNamed(AppConstants.authRoute);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
} 