import 'package:ecommerce/view/screens/SearchPage.dart';
import 'package:ecommerce/view/screens/carts.dart';
import 'package:ecommerce/view/screens/categories.dart';
import 'package:ecommerce/view/screens/home.dart';
import 'package:ecommerce/view/screens/mainScreen.dart';
import 'package:ecommerce/view/screens/productDetails.dart';
import 'package:ecommerce/view/screens/products.dart';
import 'package:ecommerce/view/screens/resultPage.dart';
import 'package:go_router/go_router.dart';

import 'config/routeNameConfig.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/searchPage',
      name: AppRoute.searchPage,
      builder: (_, _) => SearchPage(),
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
            return productDetails(id: id);
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
          case '/carts':
            index = 2;
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
          builder: (_, _) => carts(),
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
