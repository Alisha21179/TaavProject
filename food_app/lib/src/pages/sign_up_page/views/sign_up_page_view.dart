import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sign_up_page_base_controller.dart';

class SignUpPage<T extends SignUpPageBaseController> extends GetView<T> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
