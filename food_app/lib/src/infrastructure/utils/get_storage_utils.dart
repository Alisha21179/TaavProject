import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../food_app.dart';
import '../commons/models/user_view_model.dart';
import '../commons/repositories/repository_commons.dart';
import '../commons/url_commons.dart';

class GetStorageUtils {
  static const String savedUserUsernameKey = 'savedUser_username';
  static const String savedUserPasswordKey = 'savedUser_password';

  static const String loggedInUserUsernameKey = 'loggedIn_user_username';
  static const String loggedInUserPasswordKey = 'loggedIn_user_password';
}
