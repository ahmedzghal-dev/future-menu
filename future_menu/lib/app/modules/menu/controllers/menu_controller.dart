import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class MenuController extends GetxController {
  final RxString restaurantName = 'Gram Bistro'.obs;
  final RxList<Map<String, dynamic>> menuItems = <Map<String, dynamic>>[
    {
      'name': 'Avocado Toast',
      'description': 'Fresh avocado on toasted sourdough bread with olive oil and salt',
      'price': 9.99,
      'image': 'assets/images/food_plate.svg',
      'category': 'Breakfast',
    },
    {
      'name': 'Quinoa Bowl',
      'description': 'Organic quinoa, roasted vegetables, and tahini dressing',
      'price': 12.99,
      'image': 'assets/images/food_plate.svg',
      'category': 'Lunch',
    },
    {
      'name': 'Mediterranean Salad',
      'description': 'Cucumber, tomato, olives, feta cheese, and olive oil',
      'price': 8.99,
      'image': 'assets/images/food_plate.svg',
      'category': 'Lunch',
    },
  ].obs;
  
  final RxString selectedCategory = 'All'.obs;
  final RxList<String> categories = <String>['All', 'Breakfast', 'Lunch', 'Dinner', 'Food', 'Drink', 'Dessert', 'Snack'].obs;
  
  // Selected food item for the detail view
  final Rx<Map<String, dynamic>> selectedFoodItem = Rx<Map<String, dynamic>>({});
  
  // Quantity of the selected food item
  final RxInt quantity = 1.obs;
  
  // Selected toppings for the food item
  final RxList<String> selectedToppings = <String>[].obs;
  
  // Total price including the base price and toppings
  final RxDouble totalPrice = 0.0.obs;
  
  // Detailed food items with all information
  final List<Map<String, dynamic>> detailedFoodItems = [
    {
      'id': 1,
      'name': 'Avocado and Egg Toast',
      'description': 'You won\'t skip the most important meal of the day with this avocado toast recipe. Crispy, lacy eggs and creamy avocado top hot buttered toast.',
      'price': 10.00,
      'image': 'assets/images/avocado_toast.jpg',
      'rating': 5.0,
      'category': 'Breakfast',
      'nutrition': {
        'calories': 400,
        'grams': 510,
        'proteins': 30,
        'carbs': 56,
        'fats': 24
      },
      'ingredients': ['Egg', 'Avocado', 'Spinach'],
      'toppings': [
        {'name': 'Extra eggs', 'price': 4.20},
        {'name': 'Extra spinach', 'price': 2.80},
        {'name': 'Extra avocado', 'price': 5.40},
        {'name': 'Extra bread', 'price': 1.80},
        {'name': 'Extra tomato', 'price': 2.10},
        {'name': 'Extra cucumber', 'price': 1.60},
        {'name': 'Extra olives', 'price': 3.50},
        {'name': 'Extra pepper', 'price': 1.50}
      ],
      'recommended_sides': [
        {
          'name': 'Mac and Cheese',
          'price': 10.40,
          'rating': 4.9,
          'reviews': 120,
          'image': 'assets/images/mac_and_cheese.jpg'
        },
        {
          'name': 'Curry Salmon',
          'price': 10.40,
          'rating': 4.8,
          'reviews': 95,
          'image': 'assets/images/curry_salmon.jpg'
        },
        {
          'name': 'Yogurt and Fruits',
          'price': 10.40,
          'rating': 4.9,
          'reviews': 120,
          'image': 'assets/images/yogurt_and_fruits.jpg'
        }
      ]
    },
    {
      'id': 2,
      'name': 'Quinoa Bowl',
      'description': 'A healthy bowl of quinoa with fresh vegetables and herbs.',
      'price': 12.99,
      'image': 'assets/images/quinoa_bowl.jpg',
      'rating': 4.7,
      'category': 'Lunch',
      'nutrition': {
        'calories': 350,
        'grams': 450,
        'proteins': 12,
        'carbs': 62,
        'fats': 8
      },
      'ingredients': ['Quinoa', 'Avocado', 'Cherry Tomatoes', 'Cucumber'],
      'toppings': [
        {'name': 'Extra quinoa', 'price': 3.50},
        {'name': 'Extra avocado', 'price': 5.40},
        {'name': 'Extra vegetables', 'price': 2.80},
        {'name': 'Add chicken', 'price': 5.20},
        {'name': 'Add shrimp', 'price': 7.50}
      ],
      'recommended_sides': [
        {
          'name': 'Greek Salad',
          'price': 8.40,
          'rating': 4.6,
          'reviews': 85,
          'image': 'assets/images/greek_salad.jpg'
        },
        {
          'name': 'Grilled Vegetables',
          'price': 7.20,
          'rating': 4.5,
          'reviews': 78,
          'image': 'assets/images/grilled_vegetables.jpg'
        }
      ]
    }
  ];
  
  // For side dishes
  final RxMap<String, int> selectedSides = <String, int>{}.obs;
  
  // Request text
  final RxString requestText = ''.obs;
  
  // Character limit for request
  final int requestCharLimit = 50;
  
  // Filter variables
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 100.0.obs;
  final RxString sortBy = 'popularity'.obs;
  final RxList<String> selectedCategories = <String>[].obs;
  final RxList<String> dietaryPreferences = <String>[].obs;
  
  List<Map<String, dynamic>> get filteredMenuItems {
    if (selectedCategory.value == 'All') {
      return menuItems;
    } else {
      return menuItems.where((item) => item['category'] == selectedCategory.value).toList();
    }
  }
  
  void changeCategory(String category) {
    selectedCategory.value = category;
  }
  
  void addToCart(int index) {
    // In a real app, this would add the item to the cart
    Get.snackbar(
      'Added to Cart',
      '${menuItems[index]['name']} added to cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void openFoodDetail(int foodId) {
    // Find the food item by ID
    var foodItem = detailedFoodItems.firstWhere((item) => item['id'] == foodId, 
      orElse: () => detailedFoodItems[0]);
    
    selectedFoodItem.value = foodItem;
    quantity.value = 1;
    selectedToppings.clear();
    selectedSides.clear();
    updateTotalPrice();
    
    // Navigate to the food detail page
    Get.toNamed(Routes.FOOD_DETAIL);
  }
  
  void increaseQuantity() {
    quantity.value++;
    updateTotalPrice();
  }
  
  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      updateTotalPrice();
    }
  }
  
  void toggleTopping(String toppingName) {
    if (selectedToppings.contains(toppingName)) {
      selectedToppings.remove(toppingName);
    } else {
      selectedToppings.add(toppingName);
    }
    updateTotalPrice();
  }
  
  void updateSideQuantity(String sideName, int change) {
    var currentQuantity = selectedSides[sideName] ?? 0;
    var newQuantity = currentQuantity + change;
    
    if (newQuantity <= 0) {
      selectedSides.remove(sideName);
    } else {
      selectedSides[sideName] = newQuantity;
    }
    updateTotalPrice();
  }
  
  void updateTotalPrice() {
    double basePrice = selectedFoodItem.value['price'] ?? 0.0;
    double toppingsPrice = 0.0;
    
    // Add topping prices
    for (var topping in selectedToppings) {
      var toppingItem = (selectedFoodItem.value['toppings'] as List?)?.firstWhere(
        (t) => t['name'] == topping, 
        orElse: () => {'price': 0.0}
      );
      toppingsPrice += toppingItem?['price'] ?? 0.0;
    }
    
    // Add side dish prices
    double sidesPrice = 0.0;
    selectedSides.forEach((sideName, sideQuantity) {
      var sideItem = (selectedFoodItem.value['recommended_sides'] as List?)?.firstWhere(
        (s) => s['name'] == sideName,
        orElse: () => {'price': 0.0}
      );
      sidesPrice += (sideItem?['price'] ?? 0.0) * sideQuantity;
    });
    
    totalPrice.value = (basePrice * quantity.value) + toppingsPrice + sidesPrice;
  }
  
  void addToCartWithOptions() {
    // In a real app, this would add the item with selected options to the cart
    Get.snackbar(
      'Added to Cart',
      '${quantity.value}x ${selectedFoodItem.value['name']} added to cart',
      snackPosition: SnackPosition.BOTTOM,
    );
    
    // Navigate back to the menu
    Get.back();
  }
  
  void setRequestText(String text) {
    if (text.length <= requestCharLimit) {
      requestText.value = text;
    }
  }
  
  // Toggle category selection
  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  // Toggle dietary preference
  void toggleDietaryPreference(String preference) {
    if (dietaryPreferences.contains(preference)) {
      dietaryPreferences.remove(preference);
    } else {
      dietaryPreferences.add(preference);
    }
  }

  // Reset all filters
  void resetFilters() {
    minPrice.value = 0.0;
    maxPrice.value = 100.0;
    sortBy.value = 'popularity';
    selectedCategories.clear();
    dietaryPreferences.clear();
  }

  // Apply filters
  void applyFilters() {
    // Here you would implement the logic to filter the menu items
    // based on the selected filters
    // For example:
    filterMenuItems();
  }

  // Filter menu items based on selected filters
  void filterMenuItems() {
    // Implementation would depend on your data structure
    // This is a placeholder
    update();
  }
} 