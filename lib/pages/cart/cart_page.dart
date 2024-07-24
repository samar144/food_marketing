import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/app_constants.dart';
import 'package:food_delivery/colors.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/diminsions.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            left: Diminsions.width20,
            right: Diminsions.width20,
            top: Diminsions.height20 * 3,
            //bottom: Diminsions.height20*3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Diminsions.iconSize24,
                ),

                SizedBox(
                  width: Diminsions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => MainFoodpage());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Diminsions.iconSize24,
                  ),
                ),
                //SizedBox(width: Diminsions.width20*5,),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Diminsions.iconSize24,
                )
              ],
            )),
        Positioned(
            top: Diminsions.height20 * 5,
            right: Diminsions.width20,
            left: Diminsions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Diminsions.height15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController) {
                  return ListView.builder(
                    itemCount: cartController.getItems.length,
                    itemBuilder: (_, index) {
                      return Container(
                        width: double.maxFinite,
                        height: Diminsions.height20 * 5,
                        child: Row(
                          children: [
                            Container(
                              width: Diminsions.height20 * 5,
                              height: Diminsions.height20 * 5,
                              margin:
                                  EdgeInsets.only(bottom: Diminsions.height10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        cartController.getItems[index].img!)),
                                borderRadius:
                                    BorderRadius.circular(Diminsions.radius20),
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: Diminsions.width10,
                            ),
                            Expanded(
                                child: Container(
                              height: Diminsions.height20 * 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  BigText(
                                    text: cartController.getItems[index].name!,
                                    color: Colors.black54,
                                  ),
                                  SmallText(text: "spcyyyyyyyyyyyy"),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text: cartController
                                            .getItems[index].price
                                            .toString(),
                                        color: Colors.redAccent,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: Diminsions.width10,
                                            right: Diminsions.width10,
                                            top: Diminsions.height10,
                                            bottom: Diminsions.height10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Diminsions.radius20),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // PopularProduct.setQuantity(false);
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: AppColors.signColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: Diminsions.width10 / 2,
                                            ),
                                            BigText(
                                                text:
                                                    "eeeeeeeeee" //PopularProduct.inCartItems.toString()
                                                ),
                                            SizedBox(
                                              width: Diminsions.width10 / 2,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                //PopularProduct.setQuantity(true);
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: AppColors.signColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ))
      ]),
    );
  }
}
