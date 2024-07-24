import 'dart:ffi' as ui;

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/app_constants.dart';
import 'package:food_delivery/colors.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recmmended_product_controller.dart';
import 'package:food_delivery/diminsions.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.75);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Diminsions.pageviewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).size.width.toString());
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Diminsions.pageview,

                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),

                  // ),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        //dots
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Diminsions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Diminsions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(width: Diminsions.width10),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: BigText(
                    text: '.',
                    color: Colors.black26,
                  )),
              SizedBox(width: Diminsions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: 'food pairing',
                ),
              ),
            ],
          ),
        ),

        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index));
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              left: Diminsions.width20,
                              right: Diminsions.width20,
                              bottom: Diminsions.height10),
                          child: Row(
                            children: [
                              Container(
                                height: Diminsions.listViewImgSize,
                                width: Diminsions.listViewImgSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Diminsions.radius20),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(AppConstants
                                                .BASE_URL +
                                            AppConstants.UPLOAD_URL +
                                            recommendedProduct
                                                .recommendedProductList[index]
                                                .img!))),
                              ),
                              Expanded(
                                child: Container(
                                  height: Diminsions.listViewTextcontSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            Diminsions.radius20),
                                        bottomRight: Radius.circular(
                                            Diminsions.radius20)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Diminsions.width10,
                                        right: Diminsions.width10),
                                    child: Column(
                                      children: [
                                        BigText(
                                          text: recommendedProduct
                                              .recommendedProductList[index]
                                              .name!,
                                        ),
                                        SizedBox(
                                          height: Diminsions.height10,
                                        ),
                                        SmallText(
                                            text: 'with arab characteristics'),
                                        SizedBox(
                                          height: Diminsions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1,
                                            ),
                                            IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.7km",
                                              iconColor: AppColors.mainColor,
                                            ),
                                            IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: "32min",
                                              iconColor: AppColors.iconColor2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductsModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - currScale) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getPopularFood(index));
          },
          child: Container(
            height: Diminsions.pageviewContainer,
            margin: EdgeInsets.only(
                left: Diminsions.width10, right: Diminsions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Diminsions.radius30),
              color: index.isEven ? Color(0xFF89dad0) : Color(0xFF9294cc),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      popularProduct.img!)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Diminsions.pageviewtextContainer,
            margin: EdgeInsets.only(
                left: Diminsions.width30,
                right: Diminsions.width30,
                bottom: Diminsions.height30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Diminsions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ]),
            child: Container(
              padding: EdgeInsets.only(
                  top: Diminsions.height15, left: 15, right: 15),
              child: AppColumn(
                text: popularProduct.name!,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
