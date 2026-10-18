import '../provider/ResultProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/searchParameter.dart';
import '../provider/product_provider.dart';
import '../widgets/productCard.dart';

class ResultPage extends ConsumerWidget {
  final String search;
  final String type;

  const ResultPage({super.key, required this.search, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(
      resultProvider(Search(search: search, type: type)),
    );
    return Scaffold(
      appBar: AppBar(title: Text(search)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              result.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Center(child: Text(e.toString())),
                data: (list) => RefreshIndicator(
                  onRefresh: () => ref.read(productProvider.notifier).refresh(),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount;
                      if (constraints.maxWidth < 600) {
                        // Mobile
                        crossAxisCount = 2;
                      } else if (constraints.maxWidth < 900) {
                        // Tablet
                        crossAxisCount = 3;
                      } else if (constraints.maxWidth < 1200) {
                        // Small desktop
                        crossAxisCount = 4;
                      } else {
                        // Large desktop
                        crossAxisCount = 5;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (context, index) {
                          final p = list[index];

                          return ProductCard(
                            id: p.id,
                            image: p.image,
                            name: p.name,
                            price: "₹${p.price}",
                            rating: p.rating.toString(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
