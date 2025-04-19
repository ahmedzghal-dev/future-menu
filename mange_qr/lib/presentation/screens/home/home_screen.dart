import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import 'controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My QR Codes",
          style: TextStyle(
            color: AppColors.figmaTextDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.figmaLightPurple,
              child: Icon(
                Icons.person,
                color: AppColors.figmaPurple,
                size: 20,
              ),
            ),
            onPressed: controller.navigateToProfile,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshQRCodes(),
        color: AppColors.figmaPurple,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.figmaPurple,
              ),
            );
          }

          if (controller.qrCodes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.figmaLightPurple,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.qr_code_scanner_outlined,
                        size: 60,
                        color: AppColors.figmaPurple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "No QR Codes Yet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.figmaTextDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Scan or create your first QR code to get started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.figmaTextLight,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: controller.navigateToScanner,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.figmaPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text(
                      "Scan QR Code",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.qrCodes.length,
            itemBuilder: (context, index) {
              final qrCode = controller.qrCodes[index];
              return QRCodeCard(
                qrCode: qrCode,
                onTap: () => controller.navigateToDetails(qrCode),
                onDelete: () => controller.deleteQRCode(qrCode.id),
                timeAgo: controller.getTimeAgo(qrCode.createdAt),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToScanner,
        backgroundColor: AppColors.figmaPurple,
        elevation: 4,
        child: const Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
        ),
      ),
    );
  }
}

class QRCodeCard extends StatelessWidget {
  final QRCode qrCode;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final String timeAgo;

  const QRCodeCard({
    Key? key,
    required this.qrCode,
    required this.onTap,
    required this.onDelete,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.figmaLightPurple,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: qrCode.imageUrl != null
                    ? Image.asset(
                        qrCode.imageUrl!,
                        width: 60,
                        height: 60,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.qr_code_2,
                            size: 40,
                            color: AppColors.figmaPurple,
                          );
                        },
                      )
                    : Icon(
                        Icons.qr_code_2,
                        size: 40,
                        color: AppColors.figmaPurple,
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            qrCode.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.figmaTextDark,
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'delete') {
                              onDelete();
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red, size: 20),
                                    SizedBox(width: 8),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                            ];
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppColors.figmaTextLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      qrCode.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.figmaTextLight,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.figmaLightPurple,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            qrCode.type,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.figmaPurple,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            timeAgo,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.figmaTextLight,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 