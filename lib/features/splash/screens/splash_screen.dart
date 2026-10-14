import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/view_model/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_services.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/theme.dart';
import '../../auth/login/data/data_source/login_remote_data_source_impl.dart';
import '../../auth/login/data/repos/login_repo_impl.dart';
import '../../auth/login/domain/repo/login_repo.dart';
import '../../auth/login/domain/use_cases/login_use_case.dart';
import '../../auth/login/presentation/view/login_screen.dart';
import '../../main_navigation/screens/main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    final accessToken = await SecureStorage.getAccessToken();
    final refreshToken = await SecureStorage.getRefreshToken();
    if (mounted) {
      if (accessToken != null &&
          accessToken.isNotEmpty &&
          refreshToken != null &&
          refreshToken.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainNavigationScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      } else {
        final apiServices = ApiServices();

        final loginRemoteDataSource = LoginRemoteDataSourceImpl(apiServices);

        final LoginRepo loginRepo = LoginRepoImpl(loginRemoteDataSource);

        final loginUseCase = LoginUseCase(loginRepo);
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                BlocProvider(
                  create: (context) => LoginCubit(loginUseCase),
                  child: const LoginScreen(),
                ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 120, color: AppTheme.primary),
            const SizedBox(height: 24),
            Text(
              'Huma-volve',
              style: Theme.of(context).textTheme.displayLarge
                  ?.copyWith(fontSize: 40, color: AppTheme.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Ultimate E-Commerce App',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 48),
            CircularProgressIndicator(color: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}
