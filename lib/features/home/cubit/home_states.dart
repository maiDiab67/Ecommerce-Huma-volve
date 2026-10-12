import '../data/models/category_model.dart';
import '../data/models/product_model.dart';

abstract class HomeStates {
  const HomeStates();
}

class HomeInitial extends HomeStates {}

class CategoriesLoading extends HomeStates {}

class CategoriesLoaded extends HomeStates {
  final List<Category> categories;

  CategoriesLoaded(this.categories);
}

class CategoriesError extends HomeStates {
  final String errorMessage;

  CategoriesError(this.errorMessage);
}

class ProductsLoading extends HomeStates {}

class ProductsLoaded extends HomeStates {
  final List<Product> products;
  ProductsLoaded(this.products);
}

class ProductsError extends HomeStates {
  final String errorMessage;
  ProductsError(this.errorMessage);
}
