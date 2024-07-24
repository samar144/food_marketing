import 'dart:convert';

import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductsModel> _recommendedProductList = [];
  List<ProductsModel> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();

    if (response.statusCode == 200) {
      print('got products recommended');
      _recommendedProductList = [];
      // Map<String, dynamic> rawData = jsonDecode();
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print(' could not got products recommended');
    }
  }
}
