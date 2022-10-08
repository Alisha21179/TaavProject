import 'package:food_app/src/pages/login_page/forgot_pass_page/views/forgot_pass_page_view.dart';
import 'package:get/get.dart';

import '../../../food_app.dart';
import '../../pages/login_page/forgot_pass_page/commons/bindings/forgot_pass_page_bindings.dart';
import '../../pages/login_page/login_page/commons/login_page_binding.dart';
import '../../pages/login_page/login_page/views/login_page_view.dart';
import '../../pages/sign_up_page/commons/bindings/admin_sign_up_page_binding.dart';
import '../../pages/sign_up_page/commons/bindings/user_sign_up_page_binding.dart';
import '../../pages/sign_up_page/controllers/admin_sign_up_page_controller.dart';
import '../../pages/sign_up_page/controllers/user_sign_up_page_controller.dart';
import '../../pages/sign_up_page/views/sign_up_page_view.dart';
import '../../pages/splash_page/commons/splash_page_binding.dart';
import '../../pages/splash_page/views/splash_page_view.dart';

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
  ),
  GetPage(
    name: FoodAppPageRoutes.userSignupPage,
    page: SignUpPage<UserSignUpPageController>.new,
    binding: UserSignupPageBinding(),
  ),
  GetPage(
    name: FoodAppPageRoutes.loginPage,
    page: LoginPageView.new,
    binding: LoginPageBinding(),
  ),
  GetPage(
    name: FoodAppPageRoutes.forgotPassPage,
    page: ForgotPassPageView.new,
    binding: ForgotPassPageBinding(),
  )
];
