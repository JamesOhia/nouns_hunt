import 'dart:math';
import 'dart:io';
import 'dart:convert';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logger/logger.dart';
import 'package:nakama/nakama.dart';
import 'package:nouns_flutter/controllers/animations_controller.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/controllers/sp_lifelines.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/models/player_round_ranking.dart';
import 'package:nouns_flutter/models/presence_summary.dart';
import 'dart:async';
import 'package:nouns_flutter/utils/op_codes.dart' as op_codes;
import 'package:nouns_flutter/utils/nakama_helpers.dart' as nakama_helpers;

class StoreController extends GetxController {
  Logger _logger = Get.find();
  late StreamSubscription _subscription;
  List<ProductDetails> products = [];

  StoreController() {
    listenToPurchaseUpdates();
    loadProducts();
  }

  void buyCoins({required int quantity, required int cost}) {
    UserController userController = Get.find();

    if (userController.pencils < cost) {
      _logger.d("Not enough pencils to buy coins");
      throw OutOfPencilsException("Not enough pencils to to buy coins");
    }

    userController.pencils -= cost;
    userController.coins += quantity;
  }

  void listenToPurchaseUpdates() {
    UserController userController = Get.find();
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _logger.i("purchase update", purchaseDetailsList);
      purchaseDetailsList.forEach((purchaseDetails) async {
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          _logger.i("purchased", purchaseDetails);
          if (purchaseDetails.productID == "pack_pencils") {
            userController.pencils += 100;
          } else if (purchaseDetails.productID == "spare_pencils") {
            userController.pencils += 25;
          } else if (purchaseDetails.productID == "carton_pencils") {
            userController.pencils += 350;
          } else if (purchaseDetails.productID == "stationery") {
            userController.pencils += 750;
          }
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        } else if (purchaseDetails.status == PurchaseStatus.error) {
          _logger.e("error purchasing product", purchaseDetails);
        } else if (purchaseDetails.status == PurchaseStatus.pending) {
          _logger.i("pending purchase", purchaseDetails);
        }
      });
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      _logger.e("error in purchase stream", error);
    });
  }

  Future<void> loadProducts() async {
    _logger.i("loading products");
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(
      <String>{'pack_pencils', 'spare_pencils', 'carton_pencils', 'stationery'},
    );
    products = response.productDetails;
    _logger.i("products loaded", products);
  }

  ProductDetails? getProductDetails(String productId) {
    return products.firstWhere((product) => product.id == productId);
  }
}

enum Currencies {
  pencil,
  coin,
}
