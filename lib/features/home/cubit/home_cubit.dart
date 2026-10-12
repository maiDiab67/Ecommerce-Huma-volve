import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/home_repo.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial());

  void getCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await homeRepo.getCategories();
      emit(CategoriesLoaded(categories));
      getProducts(categories.first.id);
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void getProducts(int? categoryId) async {
    emit(ProductsLoading());
    try {
      final products = await homeRepo.getProducts(categoryId);
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
