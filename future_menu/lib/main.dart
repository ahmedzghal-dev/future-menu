import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/routes/app_pages.dart';
import 'app/core/theme/app_theme.dart';
import 'app/di/initial_bindings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter error: ${details.exception}');
  };

  runApp(const FutureMenuApp());
}

class FutureMenuApp extends StatelessWidget {
  const FutureMenuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Future Menu',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: Routes.SPLASH,
          initialBinding: InitialBindings(),
          getPages: AppPages.routes,
          defaultTransition: Transition.fadeIn,
          onInit: () {
            debugPrint('GetMaterialApp initialized');
          },
          onReady: () {
            debugPrint('GetMaterialApp is ready');
          },
          // onError: (error) {
          //   debugPrint('Global error handler: $error');
          // },
        );
      },
    );
  }
}
