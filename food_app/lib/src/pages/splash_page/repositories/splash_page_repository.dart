import 'package:dio/dio.dart';

class SplashPageRepository {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http//:10.0.2.2:3000',
      connectTimeout: 2000,
      sendTimeout: 2000,
      receiveTimeout: 2000,
    ),
  );

  Future<bool> getAdmin() async {
    try {
      final Response<Map<String, dynamic>> result = await dio.get(
        '/users',
        queryParameters: {'isAdmin': true},
      );
      if (result.data!.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      return false;
    }
  }
}
