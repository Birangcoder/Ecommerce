import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/routeNameConfig.dart';

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
            context.pushNamed(AppRoute.wishList);
          },
          icon: const Icon(Icons.favorite, color: Colors.blueGrey),
        ),
      ],
    );
  }
}
