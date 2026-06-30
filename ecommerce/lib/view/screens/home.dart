import 'package:flutter/material.dart';

import '../widgets/searchBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🔍 SEARCH
          searchBar(),
          Text("home screen"),
        ],
      ),
    );
  }
}
