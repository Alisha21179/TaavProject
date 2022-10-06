import 'package:dartz/dartz.dart';
import 'package:food_app/food_app.dart';
import 'package:food_app/src/pages/splash_page/repositories/splash_page_repository.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  RxBool adminAvailable = false.obs;
  RxBool showIndicator = false.obs;
  RxBool showButton = false.obs;
  RxString buttonMessage = 'مدیری وجود ندارد'.obs;
  RxString statusMessage = ''.obs;
  RxString buttonLabel = ''.obs;
  SplashPageRepository repository = SplashPageRepository();

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 2));
    await indicatorController(
      duringIndication: () async {
        await checkAdminStatusFromRepository();
      },
    );
    super.onInit();
  }

  Future<void> makeAdminButtonOnTap() async {
    _setStatusOfAdmin();
    await indicatorController();
    if (adminAvailable.value) {
      Get.offAndToNamed(FoodAppPageRoutes.loginPage);
    } else if (statusMessage.value == 'مدیری وجود ندارد') {
      Get.offAndToNamed(FoodAppPageRoutes.adminSignupPage);
    } else if (statusMessage.value == 'مشکل در ارتباط با سرور') {
      await indicatorController(
        duringIndication: () async {
          await checkAdminStatusFromRepository();
        },
      );
    }
  }

  Future<void> indicatorController(
      {Future<void>? Function()? duringIndication}) async {
    showIndicator.value = true;
    duringIndication != null ? await duringIndication() : null;
    await Future.delayed(
      const Duration(seconds: 1),
    ).then((value) => showIndicator.value = false);
  }

  void _setStatusOfAdmin() {
    // String statusMessage;
    buttonMessage.value != 'مدیری وجود ندارد'
        ? statusMessage.value = 'مشکل در ارتباط با سرور'
        : statusMessage.value = 'مدیری وجود ندارد';
    statusMessage.value == 'مشکل در ارتباط با سرور'
        ? buttonLabel.value = 'تلاش مجدد'
        : buttonLabel.value = 'ساختن مدیر';
  }

  Future<void> checkAdminStatusFromRepository() async {
    final Either<String, bool> result = await repository.getAdmin();
    result.fold(
          (l) async {
        buttonMessage.value = l;
        _setStatusOfAdmin();
        adminAvailable.value
            ? await makeAdminButtonOnTap()
            : showButton.value=true;
      },
          (r) async {
        adminAvailable.value = r;
        _setStatusOfAdmin();
        adminAvailable.value
            ? await makeAdminButtonOnTap()
            : showButton.value=true;
      },
    );
  }
}
