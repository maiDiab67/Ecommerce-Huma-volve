import 'package:dio/dio.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<List<HomeCategoryModel>> getCategories() async {
    try {
      final response = await dio.get('/categories');
      return (response.data as List)
          .map((category) => HomeCategoryModel.fromJson(category))
          .toList();
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Future<List<HomeProductModel>> getProducts(
    int categoryId, {
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await dio.get(
        '/categories/$categoryId/products',
        queryParameters: {'limit': limit, 'offset': offset},
      );
      return (response.data as List)
          .map((product) => HomeProductModel.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }
}
