import 'package:get/get.dart';
import '../models/item_model.dart';

class ItemsController extends GetxController {
  final items = <Item>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  void fetchItems() {
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      final sampleItems = [
        Item(id: 1, title: 'Task 1', description: 'Complete task 1'),
        Item(id: 2, title: 'Task 2', description: 'Complete task 2'),
        Item(id: 3, title: 'Task 3', description: 'Complete task 3'),
      ];
      
      items.assignAll(sampleItems);
      isLoading.value = false;
    });
  }

  void addItem(Item item) {
    items.add(item);
  }

  void removeItem(int id) {
    items.removeWhere((item) => item.id == id);
  }

  void toggleItemStatus(int id) {
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = items[index];
      final updatedItem = item.copyWith(isCompleted: !item.isCompleted);
      items[index] = updatedItem;
    }
  }
} 