import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/diminsions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import '../../colors.dart';

import 'food_page_body.dart';

class MainFoodpage extends StatefulWidget {
  const MainFoodpage({Key? key}) : super(key: key);

  @override
  State<MainFoodpage> createState() => _MainFoodpageState();
}

class _MainFoodpageState extends State<MainFoodpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Diminsions.height45, bottom: Diminsions.height15),
              padding: EdgeInsets.only(
                  left: Diminsions.width20, right: Diminsions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: 'Syria',
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: 'Damascus',
                            color: Colors.black54,
                          ),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Diminsions.height45,
                      height: Diminsions.height45,
                      child: Icon(Icons.search,
                          color: Colors.white, size: Diminsions.iconSize24),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Diminsions.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(child: FoodPageBody())),
        ],
      ),
    );
  }
}
