import 'package:deepcare_clock/screen/congrat/congrat_screen.dart';
import 'package:deepcare_clock/screen/home/home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class PageNavigation {

  static const String splash = '/splash';
  static const String home = '/';
  static const String congrat = '/congrats';

  static final routes = [
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: congrat, page: () => CongratScreen())
  ];
}