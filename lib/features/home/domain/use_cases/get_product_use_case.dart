import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entities/home_product_entity.dart';
import '../repo/home_repo.dart';

class GetProductUseCase {
  final HomeRepo homeRepo;
  GetProductUseCase(this.homeRepo);

  Future<Either<Failure, List<HomeProductEntity>>> invoke(
    int categoryId, {
    required int limit,
    required int offset,
  }) {
    return homeRepo.getProducts(categoryId, limit: limit, offset: offset);
  }
}
