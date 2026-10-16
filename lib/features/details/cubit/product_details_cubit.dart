import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/domain/use_cases/get_product_by_id_use_case.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductByIdUseCase getProductByIdUseCase;

  ProductDetailsCubit({required this.getProductByIdUseCase})
    : super(ProductDetailsInitial());

  Future<void> getProductById(int id) async {
    emit(ProductDetailsLoading());

    final result = await getProductByIdUseCase(id);

    if (isClosed) return;

    result.fold(
      (failure) => emit(ProductDetailsError(failure.message)),
      (product) => emit(ProductDetailsLoaded(product)),
    );
  }
}
