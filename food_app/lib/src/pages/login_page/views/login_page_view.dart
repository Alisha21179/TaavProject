import 'package:flutter/material.dart';
import 'package:food_app/src/components/background_stack.dart';
import 'package:food_app/src/pages/login_page/controllers/login_page_controller.dart';
import 'package:get/get.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BackgroundStack(
      widgetList: [
        SafeArea(
          child: Center(
            child: Text('LoginPage'),
          ),
        ),
      ],
    );
  }
}
