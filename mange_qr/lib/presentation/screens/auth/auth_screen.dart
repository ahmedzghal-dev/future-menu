import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import 'controllers/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Obx(() {
              return Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.figmaLightPurple,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.qr_code_scanner,
                            size: 48,
                            color: AppColors.figmaPurple,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      controller.isLogin.value ? "Login" : "Register",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.figmaTextDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.isLogin.value
                          ? "Welcome back! Please login to continue"
                          : "Create your account to get started",
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.figmaTextLight,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (!controller.isLogin.value) _buildNameField(controller),
                    if (!controller.isLogin.value) const SizedBox(height: 16),
                    _buildEmailField(controller),
                    const SizedBox(height: 16),
                    _buildPasswordField(controller),
                    const SizedBox(height: 16),
                    if (!controller.isLogin.value) _buildConfirmPasswordField(controller),
                    if (!controller.isLogin.value) const SizedBox(height: 16),
                    if (controller.isLogin.value)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: AppColors.figmaPurple,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Obx(() {
                        return ElevatedButton(
                          onPressed: controller.isLoading.value ? null : controller.submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.figmaPurple,
                            disabledBackgroundColor: AppColors.figmaPurple.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.0,
                                  ),
                                )
                              : Text(
                                  controller.isLogin.value ? "Login" : "Register",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.isLogin.value
                              ? "Don't have an account? "
                              : "Already have an account? ",
                          style: const TextStyle(
                            color: AppColors.figmaTextLight,
                          ),
                        ),
                        TextButton(
                          onPressed: controller.toggleAuthMode,
                          child: Text(
                            controller.isLogin.value ? "Register" : "Login",
                            style: TextStyle(
                              color: AppColors.figmaPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField(AuthController controller) {
    return TextFormField(
      controller: controller.nameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validator: controller.validateName,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.figmaGrey,
        hintText: "Full Name",
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }

  Widget _buildEmailField(AuthController controller) {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: controller.validateEmail,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.figmaGrey,
        hintText: "Email Address",
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }

  Widget _buildPasswordField(AuthController controller) {
    return Obx(() {
      return TextFormField(
        controller: controller.passwordController,
        obscureText: controller.obscurePassword.value,
        textInputAction: TextInputAction.done,
        validator: controller.validatePassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.figmaGrey,
          hintText: "Password",
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              controller.obscurePassword.value ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: controller.togglePasswordVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      );
    });
  }

  Widget _buildConfirmPasswordField(AuthController controller) {
    return Obx(() {
      return TextFormField(
        controller: controller.confirmPasswordController,
        obscureText: controller.obscureConfirmPassword.value,
        textInputAction: TextInputAction.done,
        validator: controller.validateConfirmPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.figmaGrey,
          hintText: "Confirm Password",
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              controller.obscureConfirmPassword.value ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: controller.toggleConfirmPasswordVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      );
    });
  }
} 