import 'dart:ui';
import 'package:deepcare_clock/modules/congrat_controller.dart';
import 'package:deepcare_clock/modules/home_controller.dart';
import 'package:deepcare_clock/theme/dark_theme.dart';
import 'package:deepcare_clock/theme/light_theme.dart';
import 'package:deepcare_clock/utils/page_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => CongratController())
      ],
      child: ScreenUtilInit(
        designSize: Size(390, 844),
        builder: (context, child) => MyApp(),
      )
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: PageNavigation.home,
      getPages: PageNavigation.routes,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.unknown,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad
        }
      ),
    );
  }
}
