import 'package:flutter/material.dart';
import 'package:food_app/src/components/background_stack.dart';
import 'package:get/get.dart';

import '../controllers/forgot_pass_page_controller.dart';

class ForgotPassPageView extends GetView<ForgotPassPageController> {
  const ForgotPassPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BackgroundStack(
      widgetList: [
        Center(
          child: Text('ForgotPass'),
        ),
      ],
    );
  }
}
