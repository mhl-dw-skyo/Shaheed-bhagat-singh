import 'package:get/get.dart';
import 'package:punjab_tourism/bindings/permission_binding.dart';
import 'package:punjab_tourism/views/permissions_widget.dart';

import 'core.dart';

class Router {
  static final route = [
    GetPage(
      name: '/',
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/language',
      page: () => LanguageView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => DashboardView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/emp_dashboard',
      page: () => EmpDashboardView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/detail',
      page: () => DetailView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/category_types',
      page: () => CategoryTypesView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/complaint',
      page: () => ComplaintView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/nearby',
      page: () => NearByView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/permissions',
      page: () => PermissionsWidget(),
      binding: PermissionBinding(),
    ),
    GetPage(
      name: '/verify-otp', page: () => VerifyOTPView(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: '/guest-information', page: () => GuestInformationView(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: '/guest-information-history',
      page: () => GuestInformationHistoryView(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: '/qr', page: () => QRView(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: '/eula',
      page: () => EulaView(),
    ),
    GetPage(
      name: '/thank-you',
      page: () => ThankYouView(),
    ),
  ];
}
