import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeleton_app/models/item_model.dart';
import '../controllers/items_controller.dart';
import '../widgets/custom_card.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemsController controller = Get.find<ItemsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchItems,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.items.isEmpty) {
            return const Center(child: Text('No tasks found'));
          }

          return ListView.separated(
            itemCount: controller.items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = controller.items[index];
              return CustomCard(
                title: item.title,
                subtitle: item.description,
                leading: Checkbox(
                  value: item.isCompleted,
                  onChanged: (_) => controller.toggleItemStatus(item.id),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.removeItem(item.id),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a new task functionality
          final newId =
              controller.items.isEmpty
                  ? 1
                  : controller.items
                          .map((e) => e.id)
                          .reduce((a, b) => a > b ? a : b) +
                      1;

          controller.addItem(
            Item(
              id: newId,
              title: 'New Task',
              description: 'New task description',
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
