import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../infrastructure/utils/utils.dart';
import '../controllers/my_profile_controller.dart';

class MyProfilePageView extends StatelessWidget {
  final MyProfilePageController _controller =
      Get.put(MyProfilePageController());

  MyProfilePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.8),
      body: RefreshIndicator(
        onRefresh: () async {
          await _controller.setLoggedInUser();
          _controller.setTheInfoMap();
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Utils.giantVerticalSpace,
                Utils.giantVerticalSpace,
                _avatar(context),
                Utils.mediumVerticalSpace,
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      String infoNameKey = _controller.infoNameKeys[index];
                      return Obx(
                        () => _infoItem(
                          context,
                          theInfo: _controller.infoMap[infoNameKey] ?? '',
                          infoNameKey: infoNameKey,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 3,
                        color: Theme.of(context).primaryColor,
                      );
                    },
                    itemCount: _controller.infoNameKeys.length,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Get.dialog(_logOutDialog(context));
                  },
                  child: const Text(
                    'خروج از حساب',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logOutDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        'از خروج از حساب اطمینان دارید؟',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(08),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await _controller.logOutSubmitOnTap();
                  },
                  child: const Text('بله'),
                ),
              ),
              Utils.smallHorizontalSpace,
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('خیر'),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _infoItem(
    BuildContext context, {
    required String infoNameKey,
    required String theInfo,
  }) {
    return ListTile(
      dense: true,
      leading: Text(
        infoNameKey,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Text(
        theInfo,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _avatar(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      radius: 60,
      child: const Icon(
        Icons.person,
        size: 80,
      ),
    );
  }
}
