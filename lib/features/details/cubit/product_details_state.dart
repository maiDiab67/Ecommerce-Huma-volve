import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final HomeProductEntity product;

  ProductDetailsLoaded(this.product);
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  ProductDetailsError(this.message);
}
