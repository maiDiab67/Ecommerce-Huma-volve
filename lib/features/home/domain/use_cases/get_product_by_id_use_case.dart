import 'package:dartz/dartz.dart';

import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

import '../../../../core/failure/failure.dart';
import '../repo/home_repo.dart';

class GetProductByIdUseCase {
  final HomeRepo repository;

  GetProductByIdUseCase(this.repository);

  Future<Either<Failure, HomeProductEntity>> call(int productId) {
    return repository.getProductById(productId);
  }
}
