import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_product_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductUseCase getProductsUseCase;

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitial());

  Future<void> getCategories() async {
    if (isClosed) return;

    emit(CategoriesLoading());

    try {
      final result = await getCategoriesUseCase.invoke();

      if (isClosed) return;

      result.fold(
        (failure) => emit(CategoriesError(failure.message)),
        (categories) => emit(CategoriesLoaded(categories)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> getProducts(int? categoryId) async {
    if (isClosed || categoryId == null) return;

    emit(ProductsLoading());

    try {
      final result = await getProductsUseCase.invoke(categoryId);

      if (isClosed) return;

      result.fold(
        (failure) => emit(ProductsError(failure.message)),
        (products) => emit(ProductsLoaded(products)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(ProductsError(e.toString()));
    }
  }
}
