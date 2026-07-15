import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routeNameConfig.dart';
import '../../../../widgets/header.dart';

class mainScreen extends StatelessWidget {
  final Widget child;
  final int index;

  const mainScreen({super.key, required this.child, required this.index});

  final dest = const [Text("home"), Text("categories"), Text("cart")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: header(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: child,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        selectedIndex: index,
        elevation: 2,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.goNamed(AppRoute.home);
              break;
            case 1:
              context.goNamed(AppRoute.categories);
              break;
            case 2:
              context.goNamed(AppRoute.profile);
              break;
            case 3:
              context.goNamed(AppRoute.carts);
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
            selectedIcon: Icon(Icons.home, color: Colors.blue),
          ),
          NavigationDestination(
            icon: Icon(Icons.category),
            label: "Categories",
            selectedIcon: Icon(Icons.category, color: Colors.blue),
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            selectedIcon: Icon(Icons.person, color: Colors.blue),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            selectedIcon: Icon(Icons.shopping_cart, color: Colors.blue),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}
