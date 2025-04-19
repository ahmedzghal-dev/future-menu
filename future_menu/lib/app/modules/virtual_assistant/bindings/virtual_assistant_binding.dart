import 'package:get/get.dart';
import '../controllers/virtual_assistant_controller.dart';

class VirtualAssistantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VirtualAssistantController>(
      () => VirtualAssistantController(),
    );
  }
} 