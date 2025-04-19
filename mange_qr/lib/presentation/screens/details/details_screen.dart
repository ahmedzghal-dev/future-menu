import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import 'controllers/details_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailsScreen extends GetView<DetailsController> {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Obx(() => Text(
              controller.isGenerated.value ? "Generated QR Code" : "QR Code Details",
              style: const TextStyle(
                color: AppColors.figmaTextDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
        iconTheme: const IconThemeData(color: AppColors.figmaTextDark),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.figmaPurple),
            onPressed: controller.shareQRCode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // QR Code Display
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: _buildQRCodeImage(),
                  ),
                ),
                const SizedBox(height: 32),
                
                // QR Code Type Badge
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.figmaLightPurple,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Obx(() => Text(
                          controller.qrType.value,
                          style: TextStyle(
                            color: AppColors.figmaPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Title Field
                const Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.figmaTextDark,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.titleController,
                  validator: controller.validateTitle,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.figmaGrey,
                    hintText: "Enter a title for this QR code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Description Field
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.figmaTextDark,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.descriptionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.figmaGrey,
                    hintText: "Add a description (optional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                
                // Content Display
                const Text(
                  "Content",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.figmaTextDark,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.figmaGrey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Obx(() => Text(
                        controller.qrContent.value,
                        style: const TextStyle(
                          color: AppColors.figmaTextLight,
                        ),
                      )),
                ),
                const SizedBox(height: 40),
                
                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.saveQRCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.figmaPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Save QR Code",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQRCodeImage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Obx(() {
          return QrImageView(
            data: controller.qrContent.value,
            version: QrVersions.auto,
            size: 150,
            backgroundColor: Colors.white,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: AppColors.figmaPurple,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: AppColors.figmaPurple,
            ),
          );
        }),
      ),
    );
  }
} 