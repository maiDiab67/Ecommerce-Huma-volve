import 'package:ecommerce_app_huma_volve/core/network/api_services.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../models/product_model.dart';

class HomeRepo {
  final ApiServices apiServices;
  HomeRepo(this.apiServices);

  Future<List<Category>> getCategories() async {
    final response = await apiServices.dio.get(ApiEndpoints.categories);
    final List data = response.data;
    final List<Category> categories = data
        .map((json) => Category.fromJson(json))
        .toList();
    return categories;
  }

  Future<List<Product>> getProducts(int? categoryId) async {
    final response = await apiServices.dio.get(
      "${ApiEndpoints.categories}/$categoryId/${ApiEndpoints.products}",
    );
    final List data = response.data;
    final List<Product> products = data
        .map((json) => Product.fromJson(json))
        .toList();
    return products;
  }
}
