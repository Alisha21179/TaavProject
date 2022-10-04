import 'package:food_app/src/infrastructure/routes/food_app_module_page_routes.dart';
import 'package:food_app/src/pages/sign_up_page/commons/bindings/admin_sign_up_page_binding.dart';
import 'package:food_app/src/pages/sign_up_page/controllers/admin_sign_up_page_controller.dart';
import 'package:food_app/src/pages/sign_up_page/views/sign_up_page_view.dart';
import 'package:food_app/src/pages/splash_page/views/splash_page_view.dart';
import 'package:get/get.dart';

import '../../pages/splash_page/commons/splash_page_binding.dart';

final List<GetPage> pages = [
  GetPage(
    name: FoodAppPageRoutes.splashPage,
    page: SplashPage.new,
    binding: SplashPageBinding(),
  ),
  GetPage(
    name: FoodAppPageRoutes.adminSignupPage,
    page: SignUpPage<AdminSignUpPageController>.new,
    binding: AdminSignupPageBinding(),
  )
];
