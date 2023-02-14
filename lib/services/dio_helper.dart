import 'package:dio/dio.dart';
import 'package:tasha_task/data/local/my_hive.dart';
import 'package:tasha_task/services/dio_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(
        baseUrl: 'http://tasha.accessline.ps/',
        // headers: {'authorization': MyHive.getUser(0)!.userVM!.fcmToken},
        receiveDataWhenStatusError: true),
  )..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  // static final Dio dio = Dio(BaseOptions(
  //     baseUrl: 'http://tasha.accessline.ps/',
  //     receiveDataWhenStatusError: true));

  static getData({
    required String url,
    Map<String, dynamic>? query,
    required Function(Response response) onSuccess,
    required Function(MyErrors myErrors) onFailed,
  }) async {
    try {
      dio.options.headers={
        'authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiIxMzciLCJSb2xlIjoiYiIsImp0aSI6ImY2ZjZmNmUzLWQxYjMtNGU0Ny1iZGM0LTQxNTljNGMyY2U4YSIsIm5iZiI6MTY2Mzk0MDA1MywiZXhwIjoxNjY0NTQ0ODUzLCJpYXQiOjE2NjM5NDAwNTN9.x6RcF4-pw6Kh4Xh4QNkSHKoYK8MNzA-vADm5cd9DtdM"

        // 'authorization': "Bearer ${MyHive.getUser(0)!.userVM!.fcmToken}"
      };
      Response? response = await dio.get(url, queryParameters: query);
      onSuccess(response);
    } on DioError catch (error) {
      onFailed(MyErrors(error.response, error.toString()));
    } catch (error) {
      onFailed(MyErrors(null, error.toString()));
    }
  }

  static postData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    required Function(Response response) onSuccess,
    required Function(MyErrors myError) onFailed,
  }) async {
    try {
      dio.options.headers={
        'authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiIxMzciLCJSb2xlIjoiYiIsImp0aSI6ImY2ZjZmNmUzLWQxYjMtNGU0Ny1iZGM0LTQxNTljNGMyY2U4YSIsIm5iZiI6MTY2Mzk0MDA1MywiZXhwIjoxNjY0NTQ0ODUzLCJpYXQiOjE2NjM5NDAwNTN9.x6RcF4-pw6Kh4Xh4QNkSHKoYK8MNzA-vADm5cd9DtdM"

        // 'authorization': "Bearer ${MyHive.getUser(0)!.userVM!.fcmToken}"
      };
      Response? response =
          await dio.post(url, queryParameters: query, data: data);
      onSuccess(response);
    } on DioError catch (error) {
      onFailed(MyErrors(error.response, error.message));
    } catch (error) {
      onFailed(MyErrors(null, error.toString()));
    }
  }

  static putData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    required Function(Response response) onSuccess,
    required Function(MyErrors myError) onFailed,
  }) async {
    try {
      Response? response =
          await dio.put(url, queryParameters: query, data: data);
      onSuccess(response);
    } on DioError catch (error) {
      onFailed(MyErrors(error.response, error.message));
    } catch (error) {
      onFailed(MyErrors(null, error.toString()));
    }
  }
}

class MyErrors {
  Response? response;
  late String message;

  @override
  String toString() {
    if (response != null) {
      return response?.data['msg'] ?? 'MESSAGE';
    } else {
      return message;
    }
  }

  MyErrors(this.response, this.message);
}
