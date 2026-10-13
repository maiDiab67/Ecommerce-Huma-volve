import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

abstract class HomeStates {
  const HomeStates();
}

class HomeInitial extends HomeStates {}

class CategoriesLoading extends HomeStates {}

class CategoriesLoaded extends HomeStates {
  final List<HomeCategoryEntity> categories;

  CategoriesLoaded(this.categories);
}

class CategoriesError extends HomeStates {
  final String errorMessage;

  CategoriesError(this.errorMessage);
}

class ProductsLoading extends HomeStates {}

class ProductsLoaded extends HomeStates {
  final List<HomeProductEntity> products;
  ProductsLoaded(this.products);
}

class ProductsError extends HomeStates {
  final String errorMessage;
  ProductsError(this.errorMessage);
}
