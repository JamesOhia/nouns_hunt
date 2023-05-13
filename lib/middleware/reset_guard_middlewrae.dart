import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ResetGuardMiddleWare extends GetMiddleware {
  @override
  int? priority = 1;

  @override
  RouteSettings? redirect(String? route) {
    if (route == '/reset') {
      return RouteSettings(name: '/login');
    }
    return null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    // TODO: implement onPageCalled
    return super.onPageCalled(page);
  }


}