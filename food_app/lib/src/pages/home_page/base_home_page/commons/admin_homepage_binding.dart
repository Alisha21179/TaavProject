import 'package:get/get.dart';

import '../controllers/homepage_admin_controller.dart';

class AdminHomePageBinding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut(AdminHomePageController.new);
  }

  }
