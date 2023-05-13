import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/controllers/mp_lifelines.dart';
import 'package:nouns_flutter/controllers/sp_lifelines.dart';
import 'package:nouns_flutter/controllers/store_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mainmenu/square_button.dart';
import 'package:nouns_flutter/widgets/multiplayer/mp_input_field.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/widgets/multiplayer/round_ranking_popup.dart';
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';

class StoreItem extends StatefulWidget {
  String title;
  String image;
  Currencies? currency;
  String? cost;
  String description;
  Currencies item;
  int quantity;
  String? itemId;

  StoreItem({
    super.key,
    required this.description,
    this.currency,
    this.itemId,
    this.cost,
    required this.title,
    required this.item,
    required this.quantity,
    required this.image,
  });

  @override
  State<StoreItem> createState() => _StoreItemState();
}

class _StoreItemState extends State<StoreItem> {
  StoreController _storeController = Get.find();
  Logger _logger = Get.find();
  late ProductDetails? _productDetails;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Card(
        clipBehavior: Clip.hardEdge,
        elevation: 3,
        shape: RoundedRectangleBorder(
          // side: BorderSide(),
          borderRadius: BorderRadius.circular(constraints.maxHeight * 0.1),
        ),
        child: Container(
          //  clipBehavior: Clip.hardEdge,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.05,
              vertical: constraints.maxHeight * 0.05),
          decoration: const BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(constraints.maxHeight * 0.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: constraints.maxWidth,
                // height: constraints.maxHeight * 0.15,
                child: Text(widget.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: constraints.maxHeight * 0.065,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600])),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: constraints.maxHeight * 0.01,
                  bottom: constraints.maxHeight * 0.01,
                ),
                alignment: Alignment.center,
                width: constraints.maxWidth,
                // height: constraints.maxHeight * 0.1,
                child: Text(widget.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: constraints.maxHeight * 0.055,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[400])),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: constraints.maxHeight * 0.01,
                      bottom: constraints.maxHeight * 0.01),
                  //color: Colors.grey,
                  alignment: Alignment.center,
                  width: constraints.maxWidth,
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.contain,
                    width: constraints.maxWidth * 0.6,
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  width: constraints.maxWidth,
                  height: constraints.maxWidth * 0.2,
                  child: RectangleButton(
                      textColor: darkBlueColor,
                      bgImage: "assets/images/MainMenu/blue_scaled.png",
                      width: constraints.maxWidth * 0.8,
                      height: constraints.maxWidth * 0.8 * 0.4,
                      onPressed: () {
                        makePurchase();
                      },
                      locked: false,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right: constraints.maxWidth * 0.05),
                              width: constraints.maxWidth * 0.1,
                              height: constraints.maxWidth * 0.1,
                              child: widget.currency != null
                                  ? Image.asset(widget.currency ==
                                          Currencies.pencil
                                      ? "assets/images/MainMenu/nouns_pencil.png"
                                      : "assets/images/MainMenu/dash_coins.png")
                                  : Container(),
                            ),
                            Container(
                              alignment: Alignment.center,
                              //width: constraints.maxWidth * 0.1,
                              height: constraints.maxWidth * 0.8,
                              child: Text(
                                widget.cost ?? _productDetails!.price,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: constraints.maxWidth * 0.08,
                                        color: blueColor),
                              ),
                            ),
                          ],
                        ),
                      ))),
            ],
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.itemId != null)
      _productDetails = _storeController.getProductDetails(widget.itemId!);
  }

  void makePurchase() {
    if (widget.item == Currencies.coin) {
      try {
        _storeController.buyCoins(
            quantity: widget.quantity, cost: int.parse(widget.cost!));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Purchase Successful!"),
        ));
      } on OutOfPencilsException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("You don't have enough pencils to buy this item"),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong"),
        ));
        _logger.e("Error buying coins: ${e.toString()}", e);
      }
    } else if ((widget.item == Currencies.pencil)) {
      try {
        var productDetails =
            _storeController.getProductDetails(widget.itemId!)!;

        final PurchaseParam purchaseParam =
            PurchaseParam(productDetails: productDetails);

        InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);

        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text("Purchase Successful!"),
        // ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong"),
        ));
        _logger.e("Error buying pencils: ${e.toString()}", e);
      }
    }
  }
}
