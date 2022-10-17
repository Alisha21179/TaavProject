import 'package:dartz/dartz.dart';
import 'package:food_app/food_app.dart';
import 'package:food_app/src/infrastructure/commons/models/user_view_model.dart';
import 'package:food_app/src/pages/splash_page/repositories/splash_page_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../infrastructure/utils/get_storage_utils.dart';

class SplashPageController extends GetxController {
  RxBool adminAvailable = false.obs;
  RxBool showIndicator = false.obs;
  RxBool showButton = false.obs;
  RxString buttonMessage = 'مدیری وجود ندارد'.obs;
  RxString statusMessage = ''.obs;
  RxString buttonLabel = ''.obs;
  UserViewModel? savedUser;
  SplashPageRepository repository = SplashPageRepository();
  GetStorage box = GetStorage();

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 2));
    await _indicatorController(
      duringIndication: () async {
        await _checkAdminStatusFromRepository();
      },
    );
    super.onInit();
  }

  Future<void> makeAdminButtonOnTap() async {
    _setStatusOfAdmin();
    await _indicatorController();
    if (adminAvailable.value) {
      savedUser = await _getSavedUser();
      if (savedUser != null) {
        if (savedUser!.isAdmin) {
          Get.offAndToNamed(
            FoodAppPageRoutes.adminHomePage,
            arguments: savedUser,
          );
        } else {
          Get.offAndToNamed(
            FoodAppPageRoutes.userHomePage,
            arguments: savedUser,
          );
        }
      }else{
        Get.offAndToNamed(FoodAppPageRoutes.loginPage);
      }
    } else if (statusMessage.value == 'مدیری وجود ندارد') {
      Get.offAndToNamed(FoodAppPageRoutes.adminSignupPage);
    } else if (statusMessage.value == 'مشکل در ارتباط با سرور') {
      await _indicatorController(
        duringIndication: () async {
          await _checkAdminStatusFromRepository();
        },
      );
    }
  }

  Future<void> _indicatorController(
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

  Future<void> _checkAdminStatusFromRepository() async {
    final Either<String, bool> result = await repository.getAdmin();
    result.fold(
      (l) async {
        buttonMessage.value = l;
        _setStatusOfAdmin();
        adminAvailable.value
            ? await makeAdminButtonOnTap()
            : showButton.value = true;
      },
      (r) async {
        adminAvailable.value = r;
        _setStatusOfAdmin();
        adminAvailable.value
            ? await makeAdminButtonOnTap()
            : showButton.value = true;
      },
    );
  }

  Future<UserViewModel?> _getSavedUser() async {
    String? savedUserUsername = box.read(GetStorageUtils.savedUserUsernameKey);
    String? savedUserPassword = box.read(GetStorageUtils.savedUserPasswordKey);
    UserViewModel? returnedUser;
    if (savedUserUsername == null || savedUserPassword == null) {
      Get.offAndToNamed(FoodAppPageRoutes.loginPage);
    } else {
      Either<String, UserViewModel?> result = await repository.getSavedUsers(
        username: savedUserUsername,
        password: savedUserPassword,
      );
      result.fold(
        (l) => l,
        (r) => returnedUser = r,
      );
    }
    return returnedUser;
  }
}
