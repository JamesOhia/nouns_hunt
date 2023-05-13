import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import "dart:convert";
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/auth_controller.dart';
import 'package:http/http.dart' as http;

// var  baseUrl = '34.175.74.130:7351/v2/console/api/endpoints';
var options = BaseOptions(
  baseUrl: 'http://34.175.74.130:7350/v2',
  // connectTimeout: 5000,
  // receiveTimeout: 3000,
);
Dio dio = Dio(options)..interceptors.add(dioLoggerInterceptor);

Logger logger = Get.find();
var userId = Get.find<UserController>().id;

const basicAuthorization = "Basic ZGVmYXVsdGtleTp1bmRlZmluZWQ=";
var authToken = Get.find<AuthController>().session.token;
//Map<String, dynamic> queryParams = {"http_key": "defaulthttpkey", "unwrap": ""};
Map<String, dynamic> queryParams = {"unwrap": ""};

Future<Map<String, dynamic>?> callRpc(
    {required String id, required Map<String, dynamic> body}) async {
  try {
    var response = await dio.post('/rpc/$id',
        data: body,
        queryParameters: queryParams,
        options: Options(
            headers: Map<String, dynamic>.of({
          "Authorization": "Bearer $authToken",
          "Content-Type": "application/json",
          "Accept": "application/json"
        })));
    logger.i("received response", response);
    // logger.i("received payload type ${(response.data["payload"]).runtimeType}",
    //     response.data["payload"]);
    var jsonMap = jsonDecode(response.toString()) as Map<String, dynamic>;

    logger.i("jsonmap type ${jsonMap.runtimeType}", jsonMap);
    return jsonMap;
  } catch (e) {
    logger.e("Error calling rpc $id", e);
    return null;
  }
}
