import 'package:get/get.dart';

class OrderController extends GetxController {
  // Order status: 1=preparing, 2=almost ready, 3=done
  final RxInt orderStatus = 1.obs;
  
  // Expected ready time in minutes
  final RxInt readyInMinutes = 10.obs;
  
  // Order items
  final RxList<Map<String, dynamic>> orderItems = <Map<String, dynamic>>[
    {
      'id': 1,
      'name': 'Avocado and Egg Toast',
      'price': 10.00,
      'quantity': 2,
      'image': 'assets/images/food/avocado_toast.jpg',
    },
    {
      'id': 2,
      'name': 'Curry Salmon',
      'price': 10.00,
      'quantity': 2,
      'image': 'assets/images/food/curry_salmon.jpg',
    },
    {
      'id': 3,
      'name': 'Yogurt and fruits',
      'price': 5.00,
      'quantity': 2,
      'image': 'assets/images/food/yogurt_fruits.jpg',
    },
  ].obs;
  
  // Total price
  final RxDouble itemsTotal = 45.00.obs;
  final RxDouble tax = 5.00.obs;
  final RxDouble totalPrice = 50.00.obs;
  
  // For checkout screen
  final RxList<Map<String, dynamic>> savedCards = <Map<String, dynamic>>[].obs;
  final RxBool showAddCard = false.obs;
  final RxString cardNumber = ''.obs;
  final RxString cardName = ''.obs;
  final RxString expiryDate = ''.obs;
  final RxString cvv = ''.obs;
  final RxBool saveCard = false.obs;
  final RxBool isCardFormOpen = false.obs;
  
  // Discount code
  final RxString discountCode = ''.obs;
  final RxDouble discountAmount = 0.0.obs;
  
  // Tips
  final RxDouble tipAmount = 0.0.obs;
  
  // Payment success
  final RxBool isPaymentSuccess = false.obs;
  
  // Feedback
  final RxInt rating = 0.obs;
  final RxString feedback = ''.obs;
  final RxBool showFeedbackDialog = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    calculateTotal();
  }
  
  void calculateTotal() {
    double itemTotal = 0.0;
    for (var item in orderItems) {
      itemTotal += (item['price'] ?? 0.0) * (item['quantity'] ?? 1);
    }
    
    itemsTotal.value = itemTotal;
    totalPrice.value = itemsTotal.value + tax.value - discountAmount.value + tipAmount.value;
  }
  
  void updateOrderStatus(int status) {
    orderStatus.value = status;
    // In a real app, this would communicate with a backend
  }
  
  void addMoreFood() {
    Get.toNamed('/menu');
  }
  
  void proceedToPayment() {
    Get.toNamed('/checkout');
  }
  
  void applyDiscountCode(String code) {
    // In a real app, this would validate the code with backend
    discountCode.value = code;
    if (code.isNotEmpty) {
      // Example discount of $5
      discountAmount.value = 5.0;
    } else {
      discountAmount.value = 0.0;
    }
    calculateTotal();
  }
  
  void addTip(double amount) {
    tipAmount.value = amount;
    calculateTotal();
  }
  
  void toggleAddCard() {
    showAddCard.value = !showAddCard.value;
  }
  
  void openCardForm() {
    isCardFormOpen.value = true;
  }
  
  void closeCardForm() {
    isCardFormOpen.value = false;
    cardNumber.value = '';
    cardName.value = '';
    expiryDate.value = '';
    cvv.value = '';
  }
  
  void addNewCard() {
    if (cardNumber.isNotEmpty && cardName.isNotEmpty && expiryDate.isNotEmpty && cvv.isNotEmpty) {
      savedCards.add({
        'number': cardNumber.value,
        'name': cardName.value,
        'expiry': expiryDate.value,
      });
      
      // Reset fields
      cardNumber.value = '';
      cardName.value = '';
      expiryDate.value = '';
      cvv.value = '';
      isCardFormOpen.value = false;
    }
  }
  
  void completePayment() {
    // In a real app, this would process payment
    isPaymentSuccess.value = true;
    Get.toNamed('/payment-success');
  }
  
  void continueAfterPayment() {
    // Navigate to feedback or home
    showFeedbackDialog.value = true;
    Get.toNamed('/feedback');
  }
  
  void setRating(int value) {
    rating.value = value;
  }
  
  void setFeedback(String value) {
    feedback.value = value;
  }
  
  void submitFeedback() {
    // In a real app, this would send feedback to the backend
    Get.snackbar(
      'Thank You',
      'Your feedback has been submitted',
      snackPosition: SnackPosition.BOTTOM,
    );
    
    // Navigate to home
    Get.offAllNamed('/home');
  }
  
  void skipFeedback() {
    // Navigate to home
    Get.offAllNamed('/home');
  }
} 