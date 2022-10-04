import 'package:dio/dio.dart';

import '../url_commons.dart';

class RepositoryCommons {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: UrlCommons.baseUrl,
      connectTimeout: 2000,
      sendTimeout: 2000,
      receiveTimeout: 2000,
    ),
  );
}
