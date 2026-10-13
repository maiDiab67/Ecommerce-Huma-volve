import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entities/home_category_entity.dart';
import '../entities/home_product_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<HomeProductEntity>>> getProducts(int categoryId);
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories();
}
