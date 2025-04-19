import 'package:get/get.dart';

class RewardsController extends GetxController {
  final RxList<Map<String, dynamic>> availableRewards = <Map<String, dynamic>>[].obs;
  final RxInt totalPoints = 3200.obs;
  final RxString promoCode = 'FRIEND50'.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadRewards();
  }
  
  void loadRewards() {
    // In a real app, this would fetch rewards from an API
    availableRewards.addAll([
      {
        'id': 1,
        'title': '30% Discount for all the menu',
        'isNew': true,
        'icon': 'assets/images/badge.png',
        'claimable': true,
      },
      {
        'id': 2,
        'title': 'Free delivery on next order',
        'isNew': false,
        'icon': 'assets/images/delivery.png',
        'claimable': true,
      },
      {
        'id': 3,
        'title': 'Buy 1 get 1 free on desserts',
        'isNew': false,
        'icon': 'assets/images/dessert.png',
        'claimable': false,
      },
    ]);
  }
  
  void claimReward(int rewardId) {
    final index = availableRewards.indexWhere((reward) => reward['id'] == rewardId);
    if (index != -1 && availableRewards[index]['claimable']) {
      Get.snackbar(
        'Reward Claimed',
        'You\'ve successfully claimed this reward!',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      // In a real app, this would make an API call and update the reward status
      final reward = Map<String, dynamic>.from(availableRewards[index]);
      reward['claimable'] = false;
      availableRewards[index] = reward;
    }
  }
  
  void sharePromoCode() {
    // In a real app, this would open a share dialog
    Get.snackbar(
      'Share Promo Code',
      'Sharing your promo code: $promoCode',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  String getFormattedPoints() {
    return '${totalPoints.value} points';
  }
  
  String getPointsInUsd() {
    // Assuming 100 points = $1
    final usd = totalPoints.value / 100;
    return '\$${usd.toStringAsFixed(2)} USD';
  }
} 