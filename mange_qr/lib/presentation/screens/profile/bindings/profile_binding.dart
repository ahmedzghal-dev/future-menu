import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../../core/utils/theme_service.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeService>(() => ThemeService());
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
} 