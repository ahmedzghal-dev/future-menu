import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/providers/api_provider.dart';
import '../../data/providers/storage_provider.dart';
import '../../core/utils/theme_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core services
    Get.put(ThemeService(), permanent: true);
  }
} 