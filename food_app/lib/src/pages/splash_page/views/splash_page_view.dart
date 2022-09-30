import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_page_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            ...positionedList(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _welcomeText(),
                _centerImage(),
                const SizedBox(height: 70),
                Obx(_makeAdminPart)
              ],
            ),
          ],
        ),
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
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

  List<Positioned> positionedList() {
    return [
      Positioned(
        top: -500,
        right: -300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 500,
              child: Expanded(
                child: CircleAvatar(
                  radius: 500,
                  backgroundColor: Colors.red.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 50,
        right: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Expanded(
                child: CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.red.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 230,
        right: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              child: Expanded(
                child: CircleAvatar(
                  radius: 200,
                  backgroundColor: Colors.red.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: -200,
        left: -40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Expanded(
                child: CircleAvatar(
                  radius: 300,
                  backgroundColor: Colors.red.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
