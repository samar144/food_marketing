import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/app_constants.dart';
import 'package:food_delivery/colors.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/diminsions.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/exbandable_text_widget.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    //print("page id is" + pageId.toString());
    //print("product name is" + product.name.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Diminsions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!))),
              )),
          Positioned(
              top: Diminsions.height45,
              left: Diminsions.width20,
              right: Diminsions.width20,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(() => MainFoodpage());
                        },
                        child: AppIcon(icon: Icons.arrow_back_ios)),
                    GetBuilder<PopularProductController>(builder: (controller) {
                      return Stack(children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => CartPage());
                                  },
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    backgroundColor: AppColors.mainColor,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                  ),
                                ))
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                top: 3,
                                right: 3,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ))
                            : Container()
                      ]);
                    }),
                  ])),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Diminsions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Diminsions.width20,
                    right: Diminsions.width20,
                    top: Diminsions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Diminsions.radius20),
                    topRight: Radius.circular(Diminsions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: product.name!,
                    ),
                    SizedBox(height: Diminsions.height20),
                    BigText(
                      text: 'introduce',
                    ),
                    SizedBox(height: Diminsions.height20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (PopularProduct) {
        return Container(
          height: Diminsions.bottomHeightBar,
          padding: EdgeInsets.only(
              left: Diminsions.width20,
              right: Diminsions.width20,
              top: Diminsions.height30,
              bottom: Diminsions.height30),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Diminsions.radius20 * 2),
              topRight: Radius.circular(Diminsions.radius20 * 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Diminsions.width20,
                    right: Diminsions.width20,
                    top: Diminsions.height20,
                    bottom: Diminsions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Diminsions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        PopularProduct.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Diminsions.width10 / 2,
                    ),
                    BigText(text: PopularProduct.inCartItems.toString()),
                    SizedBox(
                      width: Diminsions.width10 / 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        PopularProduct.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  PopularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: Diminsions.width20,
                      right: Diminsions.width20,
                      top: Diminsions.height20,
                      bottom: Diminsions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Diminsions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(
                    text: "\$ ${product.price!}|10 Add to cart",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
