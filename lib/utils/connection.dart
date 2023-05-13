import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/auth_controller.dart';

Logger logger = Get.find();
Future<bool> connectionOk() async {
  try {
    await Dio().get('http://34.175.74.130:7350/healthcheck');
    return true;
  } on DioError catch (e) {
    //error ocuurred most likely connection issue as google.com should just respond with success status normalyy
    logger.w('Connection Error on loading screen: ${e.message}');
    return false;
  }
}

Future<void> apiCallWithRetry(
    {required Future<void> Function() apiCall}) async {
  try {
    apiCall();
  } on GrpcError catch (e) {
    logger.w('Connection Error on api call: ${e.message}', e);
    if (e.codeName == "UNAUTHENTICATED") {
      var result = await Get.find<AuthController>()
          .signInWithGoogle(successCallback: false);
      await Future.delayed(Duration(seconds: 1));
      //apiCallWithRetry(apiCall);
      if (result == AuthResult.success) {
        apiCall();
      } else {
        logger.e(
            'Connection failed on api retry on api call: ${e.toString()}', e);
      }
    }
    apiCall();
  } catch (e) {
    logger.e('Connection failed terminally on api call: ${e.toString()}', e);
  }
}
