import 'package:get/get.dart';

class CartController extends GetxController {
  // List of items in cart
  final RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  
  // Total price of all items in cart
  final RxDouble totalPrice = 0.0.obs;
  
  // Delivery fee
  final RxDouble deliveryFee = 2.99.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Load sample data for demo
    _loadSampleData();
    _calculateTotal();
  }
  
  // Add item to cart
  void addToCart(Map<String, dynamic> item) {
    // Check if item already exists in cart
    int existingIndex = cartItems.indexWhere((element) => element['id'] == item['id']);
    
    if (existingIndex >= 0) {
      // Update quantity if item exists
      cartItems[existingIndex]['quantity'] = (cartItems[existingIndex]['quantity'] ?? 1) + (item['quantity'] ?? 1);
    } else {
      // Add new item
      cartItems.add(item);
    }
    
    _calculateTotal();
    Get.snackbar(
      'Item Added',
      '${item['name']} added to cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  // Remove item from cart
  void removeFromCart(int index) {
    String itemName = cartItems[index]['name'];
    cartItems.removeAt(index);
    _calculateTotal();
    
    Get.snackbar(
      'Item Removed',
      '$itemName removed from cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  // Update item quantity
  void updateQuantity(int index, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(index);
    } else {
      cartItems[index]['quantity'] = newQuantity;
      _calculateTotal();
    }
  }
  
  // Increment item quantity
  void incrementQuantity(int index) {
    cartItems[index]['quantity'] = (cartItems[index]['quantity'] ?? 1) + 1;
    _calculateTotal();
  }
  
  // Decrement item quantity
  void decrementQuantity(int index) {
    int currentQuantity = cartItems[index]['quantity'] ?? 1;
    if (currentQuantity <= 1) {
      removeFromCart(index);
    } else {
      cartItems[index]['quantity'] = currentQuantity - 1;
      _calculateTotal();
    }
  }
  
  // Clear cart
  void clearCart() {
    cartItems.clear();
    _calculateTotal();
  }
  
  // Calculate total price of items in cart
  void _calculateTotal() {
    double sum = 0;
    for (var item in cartItems) {
      sum += (item['price'] ?? 0) * (item['quantity'] ?? 1);
    }
    totalPrice.value = sum;
  }
  
  // Add more food from menu
  void addMoreFood() {
    Get.toNamed('/menu');
  }
  
  // Proceed to checkout
  void checkout() {
    // In a real app, this would navigate to checkout
    Get.toNamed('/checkout');
  }
  
  // Load sample data for demo
  void _loadSampleData() {
    cartItems.addAll([
      {
        'id': 1,
        'name': 'Avocado and Egg Toast',
        'price': 10.40,
        'quantity': 2,
        'image': 'assets/images/avocado_toast.jpg',
        'rating': 4.9,
        'reviews': 120
      },
      {
        'id': 2,
        'name': 'Curry Salmon',
        'price': 10.40,
        'quantity': 1,
        'image': 'assets/images/curry_salmon.jpg',
        'rating': 4.9,
        'reviews': 120
      },
      {
        'id': 3,
        'name': 'Yogurt and Fruits',
        'price': 10.40,
        'quantity': 1,
        'image': 'assets/images/yogurt_and_fruits.jpg',
        'rating': 4.9,
        'reviews': 120
      }
    ]);
  }
} 