import 'package:dartz/dartz.dart';
import 'package:food_app/food_app.dart';
import 'package:food_app/src/pages/splash_page/repositories/splash_page_repository.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  RxBool adminAvailable = false.obs;
  RxBool showIndicator = false.obs;
  RxString buttonMessage = 'مدیری وجود ندارد'.obs;
  RxString statusMessage = ''.obs;
  SplashPageRepository repository = SplashPageRepository();
  RxString buttonLabel = ''.obs;

  @override
  void onInit() async {
    await indicatorController(
      duringIndication: () async {
        await checkAdminStatusFromRepository();
      },
    );
    super.onInit();
  }

  Future<void> makeAdminButton() async {
    adminAvailable.value = false;
    _statusOfAdmin();
    await indicatorController();
    if (statusMessage.value == 'مدیری وجود ندارد') {
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

  void _statusOfAdmin() {
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
        _statusOfAdmin();
        adminAvailable.value
            ? await makeAdminButton()
            : await indicatorController();
      },
      (r) async {
        adminAvailable.value = r;
        _statusOfAdmin();
        adminAvailable.value
            ? await makeAdminButton()
            : await indicatorController();
      },
    );
  }
}
