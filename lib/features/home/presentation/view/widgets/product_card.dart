import 'package:ecommerce_app_huma_volve/features/details/cubit/product_details_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_product_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_services.dart';
import '../../../../../core/theme.dart';
import '../../../../details/screens/product_details_screen.dart';
import '../../../data/data_source/home_remote_data_source.dart';
import '../../../data/data_source/home_remote_data_source_impl.dart';
import '../../../data/repo/home_repo_impl.dart';
import '../../../domain/repo/home_repo.dart';
import '../../../domain/use_cases/get_product_by_id_use_case.dart';
import '../../view_model/home_cubit.dart';

class ProductCard extends StatelessWidget {
  final HomeProductEntity product;
  late final ApiServices apiServices;
  late final HomeRepo homeRepo;
  late final HomeRemoteDataSource homeRemoteDataSource;
  late final GetProductByIdUseCase getProductByIdUseCase;
  late final GetCategoriesUseCase getCategoriesUseCase;
  late final GetProductUseCase getProductUseCase;
  late final HomeCubit homeCubit;
  ProductCard({super.key, required this.product});
  String? cleanImageUrl(String? raw) {
    if (raw == null) return null;

    final match = RegExp(r'https?://[^\s"\\\]\[,]+').firstMatch(raw);
    if (match == null) return null;

    var url = match.group(0)!;

    // placehold.co serves SVG by default, which Flutter can't decode
    if (url.contains('placehold.co')) {
      final base = url.split('?').first;
      url = base.endsWith('.png') ? base : '$base.png';
    }

    // placeimg.com is shut down
    if (url.contains('placeimg.com')) return null;

    return url;
  }

  @override
  Widget build(BuildContext context) {
    apiServices = ApiServices();
    homeRemoteDataSource = HomeRemoteDataSourceImpl(apiServices.dio);
    homeRepo = HomeRepoImpl(homeRemoteDataSource);
    getProductByIdUseCase = GetProductByIdUseCase(homeRepo);
    getCategoriesUseCase = GetCategoriesUseCase(homeRepo);
    getProductUseCase = GetProductUseCase(homeRepo);
    homeCubit = HomeCubit(
      getCategoriesUseCase: getCategoriesUseCase,
      getProductsUseCase: getProductUseCase,
    );
    final imageUrl = (product.images != null && product.images!.isNotEmpty)
        ? cleanImageUrl(product.images!.first)
        : null;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) {
              return BlocProvider(
                create: (_) => ProductDetailsCubit(
                  getProductByIdUseCase: getProductByIdUseCase,
                )..getProductById(product.id!),
                child: ProductDetailsScreen(productId: product.id!),
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.08),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Hero(
                    tag: 'product-${product.id}',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: SizedBox.expand(
                        child: imageUrl == null
                            ? const _ImageFallback()
                            : Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const _ImageFallback(),
                                loadingBuilder: (context, child, progress) =>
                                    progress == null
                                    ? child
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                              ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: AppTheme.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined, color: Colors.grey),
      ),
    );
  }
}
