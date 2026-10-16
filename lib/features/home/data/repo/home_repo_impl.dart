import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handling.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entities/home_category_entity.dart';
import '../../domain/entities/home_product_entity.dart';
import '../../domain/repo/home_repo.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<HomeProductEntity>>> getProducts(
    int categoryId, {
    required int limit,
    required int offset,
  }) async {
    try {
      final products = await remoteDataSource.getProducts(
        categoryId,
        limit: limit,
        offset: offset,
      );
      return Right(products as List<HomeProductEntity>);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories as List<HomeCategoryEntity>);
    } catch (e) {
      return Left(ErrorHandling.handleError(e));
    }
  }
}
