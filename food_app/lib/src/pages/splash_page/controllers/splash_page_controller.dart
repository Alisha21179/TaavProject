import 'package:food_app/food_app.dart';
import 'package:food_app/src/pages/splash_page/repositories/splash_page_repository.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  RxBool adminAvailable = false.obs;
  RxBool showIndicator = false.obs;
  SplashPageRepository repository = SplashPageRepository();

  @override
  void onInit() async {
    adminAvailable.value = await repository.getAdmin();
    adminAvailable.value
        ? await makeAdminButton()
        : await indicatorController();
    super.onInit();
  }

  Future<void> makeAdminButton() async {
    adminAvailable.value = false;
    await indicatorController();
    Get.offAndToNamed(FoodAppPageRoutes.adminSignupPage);
  }

  Future<void> indicatorController() async {
    showIndicator.value = true;
    await Future.delayed(
      const Duration(seconds: 2),
    ).then((value) => showIndicator.value = false);
  }
}
