import 'package:ecommerce/features/auth/presentation/provider/authProvider.dart';
import 'package:ecommerce/core/provider/goRouterProvider.dart';
import 'package:ecommerce/features/searchResult/presentation/pages/SearchPage.dart';
import 'package:ecommerce/features/wishlist/presentation/pages/WishlistPage.dart';
import 'package:ecommerce/features/cart/presentation/pages/carts.dart';
import 'package:ecommerce/features/category/presentation/pages/categories.dart';
import 'package:ecommerce/features/help&support/presentation/page/helpSupport.dart';
import 'package:ecommerce/features/auth/presentation/pages/login.dart';
import 'package:ecommerce/features/mainScreen/presentation/page/mainScreen.dart';
import 'package:ecommerce/features/order/presentation/pages/my_order.dart';
import 'package:ecommerce/features/product/presentation/pages/productDetails.dart';
import 'package:ecommerce/features/profile/presentation/page/profile.dart';
import 'package:ecommerce/features/product/presentation/pages/resultPage.dart';
import 'package:ecommerce/features/auth/presentation/pages/userDetails.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/routeNameConfig.dart';
import '../features/home/presentation/page/home.dart';
import '../features/product/presentation/pages/products.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(goRouterRefreshProvider);

  return GoRouter(
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final container = ProviderScope.containerOf(context);
      final authState = container.read(authProvider);
      // Don't make a redirect decision until we actually know the auth state
      if (authState.isLoading) return null;

      final isLoggedIn = authState.value != null;
      final isLoginPage = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoginPage) return '/login';
      if (isLoggedIn && isLoginPage) return '/';
      return null;
    },

    routes: [
      GoRoute(path: '/login', name: AppRoute.login, builder: (_, _) => Login()),
      GoRoute(
        path: '/searchPage',
        name: AppRoute.searchPage,
        builder: (_, _) => SearchPage(),
      ),
      GoRoute(
        path: '/WishlistPage',
        name: AppRoute.wishList,
        builder: (_, _) => WishlistPage(),
      ),
      GoRoute(
        path: '/userDetails',
        name: AppRoute.userDetails,
        builder: (_, _) => UserDetails(),
      ),
      GoRoute(
        path: '/myOrder',
        name: AppRoute.myOrder,
        builder: (_, _) => MyOrderScreen(),
      ),
      GoRoute(
        path: '/helpSupport',
        name: AppRoute.helpSupport,
        builder: (_, _) => HelpSupport(),
      ),
      GoRoute(
        path: '/products',
        name: AppRoute.product,
        builder: (_, _) => const products(),
        routes: [
          GoRoute(
            path: ':id',
            name: AppRoute.productDetails,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ProductDetails(id: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/result/:category',
        name: AppRoute.resultPage,
        builder: (context, state) {
          final category = state.pathParameters['category']!;
          final type = state.extra as String;
          return ResultPage(search: category, type: type);
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          int index = 0;
          switch (state.uri.path) {
            case '/':
              index = 0;
              break;
            case '/categories':
              index = 1;
              break;
            case '/profile':
              index = 2;
              break;
            case '/carts':
              index = 3;
              break;
          }

          return mainScreen(index: index, child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: AppRoute.home,
            builder: (_, _) => const HomeScreen(),
          ),

          GoRoute(
            path: '/carts',
            name: AppRoute.carts,
            builder: (_, _) => Carts(),
          ),

          GoRoute(
            path: '/profile',
            name: AppRoute.profile,
            builder: (_, _) => ProfileScreen(),
          ),

          GoRoute(
            path: '/categories',
            name: AppRoute.categories,
            builder: (_, _) => categories(),
          ),
        ],
      ),
    ],
  );
});
