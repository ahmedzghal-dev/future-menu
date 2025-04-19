import 'package:get/get.dart';
import '../controllers/verify_code_controller.dart';

class VerifyCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyCodeController>(
      () => VerifyCodeController(),
    );
  }
} 