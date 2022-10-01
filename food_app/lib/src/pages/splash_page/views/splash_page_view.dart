import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/background_stack.dart';
import '../controllers/splash_page_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundStack(
      widgetList: [
        _mainBody(),
      ],
    );
  }

  Widget _mainBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _welcomeText(),
        _centerImage(),
        const SizedBox(height: 70),
        Obx(_makeAdminPart)
      ],
    );
  }

  Widget _welcomeText() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'به برنامه سفارش غذا خوش آمدید',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _makeAdminPart() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.showIndicator.value
              ? _circularIndicator()
              : _makeAdminButton()
        ],
      ),
    );
  }

  Widget _circularIndicator() {
    return const SizedBox(
      height: 40,
      // width: 40,
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        strokeWidth: 3,
      ),
    );
  }

  Widget _makeAdminButton() {
    return Column(
      children: [
        const Text(
          'مدیری وجود ندارد',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Color.fromRGBO(148, 6, 6, 1.0)),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () async {
              await controller.makeAdminButton();
            },
            icon: const Icon(Icons.manage_accounts),
            label: const Text(
              'ساختن مدیر',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget _centerImage() {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 3,
          child: Image.asset(
            'lib/assets/images/splash_page_hamburger.png',
            fit: BoxFit.contain,
            package: 'food_app',
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
