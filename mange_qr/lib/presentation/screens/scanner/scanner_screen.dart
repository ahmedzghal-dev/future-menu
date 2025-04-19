import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:io';
import '../../../core/constants/colors.dart';
import 'controllers/scanner_controller.dart';

class ScannerScreen extends GetView<ScannerController> {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Obx(() => Text(
              controller.isGenerateMode.value ? "Generate QR Code" : "Scan QR Code",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                controller.isGenerateMode.value ? Icons.qr_code_scanner : Icons.qr_code_2,
                color: Colors.white,
              ),
              onPressed: controller.toggleMode,
            );
          }),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Obx(() {
        if (controller.isGenerateMode.value) {
          return _buildGenerateView();
        } else {
          return _buildScannerView(context);
        }
      }),
    );
  }

  Widget _buildScannerView(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller.scannerController,
          onDetect: controller.onDetect,
          overlay: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double scanAreaSize = constraints.maxWidth * 0.7;
                return Stack(
                  children: [
                    Center(
                      child: Container(
                        width: scanAreaSize,
                        height: scanAreaSize,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: AppColors.figmaPurple,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildControlButton(
                icon: Obx(() => Icon(
                      controller.isFlashOn.value
                          ? Icons.flash_on
                          : Icons.flash_off,
                      color: Colors.white,
                    )),
                onPressed: controller.toggleFlash,
              ),
              const SizedBox(width: 40),
              _buildControlButton(
                icon: const Icon(
                  Icons.flip_camera_ios,
                  color: Colors.white,
                ),
                onPressed: controller.toggleCamera,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 140,
          left: 0,
          right: 0,
          child: Center(
            child: const Text(
              "Position the QR code in the frame to scan",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenerateView() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter content for your QR code",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.figmaTextLight,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.textController,
                  validator: controller.validateQRContent,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.figmaGrey,
                    hintText: "URL, text, contact info, or other data",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.generateQRCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.figmaPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Generate QR Code",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "You can generate QR codes for:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.figmaTextDark,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const _QRTypeItem(
                  icon: Icons.link,
                  text: "URLs (e.g., https://example.com)",
                ),
                const SizedBox(height: 8),
                const _QRTypeItem(
                  icon: Icons.phone,
                  text: "Phone numbers (e.g., +123456789)",
                ),
                const SizedBox(height: 8),
                const _QRTypeItem(
                  icon: Icons.email,
                  text: "Email addresses (e.g., user@example.com)",
                ),
                const SizedBox(height: 8),
                const _QRTypeItem(
                  icon: Icons.text_fields,
                  text: "Plain text (e.g., any text message)",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.black38,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white30,
          width: 1,
        ),
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}

class _QRTypeItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _QRTypeItem({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.figmaLightPurple,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.figmaPurple,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.figmaTextLight,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
} 