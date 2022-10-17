import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../../infrastructure/commons/models/user_view_model.dart';
import '../../../../../../../infrastructure/routes/food_app_module_page_routes.dart';
import '../../../../../../../infrastructure/utils/get_storage_utils.dart';
import '../repositories/my_profile_page_repository.dart';

class MyProfilePageController extends GetxController {
  Rxn<UserViewModel> loggedInUser = Rxn(null);
  final MyProfilePageRepository repository = MyProfilePageRepository();
  final List<String> infoNameKeys = const [
    'نام',
    'نام خانوادگی',
    'آدرس',
    'تاریخ تولد',
    'شماره تلفن همراه',
  ];
  RxMap<String, String> infoMap = RxMap<String, String>();
  final GetStorage _box = GetStorage();

  @override
  void onInit() async {
    await setLoggedInUser();
    setTheInfoMap();
    super.onInit();
  }

  Future<void> setLoggedInUser() async {
    loggedInUser.value = await _getSavedUser(
      savedUsernameKey: GetStorageUtils.loggedInUserUsernameKey,
      savedUserPasswordKey: GetStorageUtils.loggedInUserPasswordKey,
    );
  }

  void setTheInfoMap() {
    infoMap[infoNameKeys[0]] =
        loggedInUser.value != null ? loggedInUser.value!.name : '';
    infoMap[infoNameKeys[1]] =
        loggedInUser.value != null ? loggedInUser.value!.family : '';
    infoMap[infoNameKeys[2]] =
        loggedInUser.value != null ? loggedInUser.value!.address : '';
    infoMap[infoNameKeys[3]] =
        loggedInUser.value != null ? loggedInUser.value!.birthday : '';
    infoMap[infoNameKeys[4]] =
        loggedInUser.value != null ? loggedInUser.value!.phoneNumber : '';
  }

  Future<UserViewModel?> _getSavedUser({
    required String savedUsernameKey,
    required String savedUserPasswordKey,
  }) async {
    String? savedUserUsername = _box.read(savedUsernameKey);
    String? savedUserPassword = _box.read(savedUserPasswordKey);
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

  Future<void> logOutSubmitOnTap() async {
    await _box.remove(GetStorageUtils.savedUserUsernameKey);
    await _box.remove(GetStorageUtils.savedUserPasswordKey);
    await _box.remove(GetStorageUtils.loggedInUserUsernameKey);
    await _box.remove(GetStorageUtils.loggedInUserPasswordKey);
    Get.offNamedUntil(FoodAppPageRoutes.loginPage, (route) => false);
    Get.offAndToNamed(FoodAppPageRoutes.loginPage);
  }
}
