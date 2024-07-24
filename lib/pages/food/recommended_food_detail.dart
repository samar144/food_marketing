import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/app_constants.dart';
import 'package:food_delivery/colors.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recmmended_product_controller.dart';
import 'package:food_delivery/diminsions.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/exbandable_text_widget.dart';
import 'package:get/get.dart';

import '../../widgets/big_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.clear)),
                // AppIcon(icon: Icons.shopping_cart_outlined),

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
                            top: 0,
                            right: 0,
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
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child:
                        BigText(size: Diminsions.font26, text: product.name!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Diminsions.radius20),
                      topRight: Radius.circular(Diminsions.radius20)),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                child: ExpandableTextWidget(text: product.description!),
                margin: EdgeInsets.only(
                    left: Diminsions.width20, right: Diminsions.width20),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Diminsions.width20 * 2.5,
                right: Diminsions.width20 * 2.5,
                top: Diminsions.height10,
                bottom: Diminsions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      iconSize: Diminsions.iconSize24,
                      icon: Icons.remove,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                  BigText(
                    text:
                        ' \$ ${product.price!} X   ${controller.inCartItems} ',
                    color: AppColors.mainBlackColor,
                    size: Diminsions.font26,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      iconSize: Diminsions.iconSize24,
                      icon: Icons.add,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                        borderRadius:
                            BorderRadius.circular(Diminsions.radius20),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                        size: Diminsions.iconSize24,
                      )),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: Diminsions.width20,
                          right: Diminsions.width20,
                          top: Diminsions.height20,
                          bottom: Diminsions.height20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Diminsions.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: BigText(
                        text: '\$ ${product.price!}| Add to cart',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
