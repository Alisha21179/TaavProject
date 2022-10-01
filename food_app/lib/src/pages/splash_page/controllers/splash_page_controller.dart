import 'package:dartz/dartz.dart';
import 'package:food_app/food_app.dart';
import 'package:food_app/src/pages/splash_page/repositories/splash_page_repository.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  RxBool adminAvailable = false.obs;
  RxBool showIndicator = false.obs;
  RxString buttonMessage = 'مدیری وجود ندارد'.obs;
  SplashPageRepository repository = SplashPageRepository();

  @override
  void onInit() async {
    indicatorController(
      duringIndication: () async {
        final Either<String, bool> result = await repository.getAdmin();
        result.fold(
          (l) async {
            adminAvailable.value
                ? await makeAdminButton()
                : await indicatorController();
            buttonMessage.value = l;
            statusOfAdmin();
          },
          (r) async {
            adminAvailable.value
                ? await makeAdminButton()
                : await indicatorController();
            adminAvailable.value = r;
            statusOfAdmin();
          },
        );
      },
    );
    super.onInit();
  }

  Future<void> makeAdminButton() async {
    adminAvailable.value = false;
    await indicatorController();
    Get.offAndToNamed(FoodAppPageRoutes.adminSignupPage);
  }

  Future<void> indicatorController(
      {Future<void>? Function()? duringIndication}) async {
    showIndicator.value = true;
    duringIndication != null ? await duringIndication() : null;
    await Future.delayed(
      const Duration(seconds: 2),
    ).then((value) => showIndicator.value = false);
  }

  String statusOfAdmin() {
    String statusMessage;
    buttonMessage.value != 'مدیری وجود ندارد'
        ? statusMessage = 'مشکل در ارتباط با سرور'
        : statusMessage = 'مدیری وجود ندارد';
    return statusMessage;
  }
}
