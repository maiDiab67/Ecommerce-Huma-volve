import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entities/home_category_entity.dart';
import '../repo/home_repo.dart';

class GetCategoriesUseCase {
  final HomeRepo homeRepo;
  GetCategoriesUseCase(this.homeRepo);

  Future<Either<Failure, List<HomeCategoryEntity>>> invoke() {
    return homeRepo.getCategories();
  }
}
