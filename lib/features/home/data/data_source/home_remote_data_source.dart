import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeCategoryModel>> getCategories();
  Future<List<HomeProductModel>> getProducts(
    int categoryId, {
    required int limit,
    required int offset,
  });
  Future<HomeProductModel> getProductById(int productId);
}
