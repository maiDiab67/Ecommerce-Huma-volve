import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_screen.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/details/cubit/product_details_cubit.dart';
import '../../features/home/domain/use_cases/get_product_by_id_use_case.dart';

final appRouting = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final productId = int.parse(state.pathParameters['id']!);
        return BlocProvider(
          create: (context) => ProductDetailsCubit(
            getProductByIdUseCase: context.read<GetProductByIdUseCase>(),
          )..getProductById(productId),
          child: ProductDetailsScreen(productId: productId),
        );
      },
    ),
  ],
);
