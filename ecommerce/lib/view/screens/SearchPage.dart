import 'package:ecommerce/config/routeNameConfig.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search here...",
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Color(0xFF6F6F70), width: 2),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Color(0xFF00A2E8), width: 2),
            ),

            prefixIcon: const Icon(Icons.search),
          ),
          onSubmitted: (value) {
            context.pushNamed(
              AppRoute.resultPage,
              pathParameters: {"category": value},
              extra: 'search'
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.trending_up, size: 30, color: Colors.redAccent),
                SizedBox(width: 4),
                Text(
                  "Trending Now",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                trendingItem("Fresh Fruits"),
                trendingItem("Dairy Products"),
                trendingItem("Organic Vegetables"),
                trendingItem("Breakfast Items"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget trendingItem(String text) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: Container(
      color: Color(0xFFFFDDDE),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        text,
        style: TextStyle(fontSize: 17),
      ),
    ),
  );
}