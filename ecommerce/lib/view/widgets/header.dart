import 'package:ecommerce/config/routeNameConfig.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class header extends StatelessWidget {
  const header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Ecommerce App",
          style: TextStyle(
            // fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            context.goNamed(AppRoute.carts);
          },
          icon: const Icon(Icons.shopping_cart, color: Color(0xFF2B3745)),
        ),
      ],
    );
  }
}
