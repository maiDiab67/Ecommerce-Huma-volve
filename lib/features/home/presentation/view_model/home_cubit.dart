import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_product_use_case.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductUseCase getProductsUseCase;

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitial());

  static const int limit = 10;

  int offset = 0;
  int? selectedCategory;

  bool isLoadingMore = false;
  bool hasMore = true;

  final List<HomeProductEntity> _products = [];

  Future<void> getCategories() async {
    emit(CategoriesLoading());

    final result = await getCategoriesUseCase.invoke();

    if (isClosed) return;

    await result.fold<Future<void>>(
      (failure) async {
        emit(CategoriesError(failure.message));
      },
      (categories) async {
        emit(CategoriesLoaded(categories));

        if (categories.isEmpty) return;

        final categoryId = categories.first.id;

        if (categoryId == null) return;

        await getProducts(categoryId);
      },
    );
  }

  Future<void> getProducts(int categoryId) async {
    selectedCategory = categoryId;

    offset = 0;
    hasMore = true;
    isLoadingMore = false;
    _products.clear();

    emit(ProductsLoading());

    final result = await getProductsUseCase.invoke(
      categoryId,
      offset: offset,
      limit: limit,
    );

    if (isClosed || selectedCategory != categoryId) return;

    result.fold(
      (failure) {
        emit(ProductsError(failure.message));
      },
      (products) {
        _products.addAll(products);
        offset = _products.length;

        hasMore = products.length == limit;

        emit(ProductsLoaded(List.of(_products)));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    final categoryId = selectedCategory;

    if (categoryId == null || isLoadingMore || !hasMore || isClosed) {
      return;
    }

    isLoadingMore = true;

    try {
      final result = await getProductsUseCase.invoke(
        categoryId,
        offset: offset,
        limit: limit,
      );

      if (isClosed || selectedCategory != categoryId) return;

      result.fold(
        (failure) {
          emit(ProductLoadingMoreError(failure.message));
        },
        (newProducts) {
          _products.addAll(newProducts);
          offset = _products.length;

          if (newProducts.length < limit) {
            hasMore = false;
          }

          emit(ProductsLoaded(List.of(_products)));
        },
      );
    } finally {
      isLoadingMore = false;
    }
  }
}
