import 'package:get/get.dart';

import '../../../food_app.dart';
import '../../pages/home_page/base_home_page/commons/admin_homepage_binding.dart';
import '../../pages/home_page/base_home_page/commons/user_homepage_binding.dart';
import '../../pages/home_page/base_home_page/controllers/homepage_admin_controller.dart';
import '../../pages/home_page/base_home_page/controllers/homepage_user_controller.dart';
import '../../pages/home_page/base_home_page/views/home_page_view.dart';
import '../../pages/login_page/login_page/commons/forgot_pass_binding.dart';
import '../../pages/login_page/login_page/commons/login_page_binding.dart';
import '../../pages/login_page/login_page/controllers/forgot_pass_controller.dart';
import '../../pages/login_page/login_page/controllers/login_page_login_controller.dart';
import '../../pages/login_page/login_page/views/login_page_view.dart';
import '../../pages/sign_up_page/commons/bindings/admin_sign_up_page_binding.dart';
import '../../pages/sign_up_page/commons/bindings/user_sign_up_page_binding.dart';
import '../../pages/sign_up_page/controllers/admin_sign_up_page_controller.dart';
import '../../pages/sign_up_page/controllers/user_sign_up_page_controller.dart';
import '../../pages/sign_up_page/views/sign_up_page_view.dart';
import '../../pages/splash_page/commons/splash_page_binding.dart';
import '../../pages/splash_page/views/splash_page_view.dart';

final List<GetPage> foodAppPages = [
  ///SplashPage
  GetPage(
    name: FoodAppPageRoutes.splashPage,
    page: SplashPage.new,
    binding: SplashPageBinding(),
  ),

  ///AdminSignUpPage
  GetPage(
    name: FoodAppPageRoutes.adminSignupPage,
    page: SignUpPage<AdminSignUpPageController>.new,
    binding: AdminSignupPageBinding(),
  ),

  ///UserSignUpPage
  GetPage(
    name: FoodAppPageRoutes.userSignupPage,
    page: SignUpPage<UserSignUpPageController>.new,
    binding: UserSignupPageBinding(),
  ),

  ///LoginPage
  GetPage(
    name: FoodAppPageRoutes.loginPage,
    page: LoginPageView<LoginPageController>.new,
    binding: LoginPageBinding(),
  ),

  ///ForgotPassPage
  GetPage(
    name: FoodAppPageRoutes.forgotPassPage,
    page: LoginPageView<ForgotPassController>.new,
    binding: ForgotPassBinding(),
  ),

  ///AdminHomePage
  GetPage(
    name: FoodAppPageRoutes.adminHomePage,
    page: BaseHomePageView<AdminHomePageController>.new,
    binding: AdminHomePageBinding(),
  ),

  ///UserHomePage
  GetPage(
    name: FoodAppPageRoutes.userHomePage,
    page: BaseHomePageView<UserHomePageController>.new,
    binding: UserHomePageBinding(),
  )
];
