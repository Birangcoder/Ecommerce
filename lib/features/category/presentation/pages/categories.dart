import 'package:ecommerce/features/category/presentation/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget/category_card.dart';

class Categories extends ConsumerWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              categories.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Center(child: Text(e.toString())),
                data: (list) => RefreshIndicator(
                  onRefresh: () =>
                      ref.read(categoryProvider.notifier).refresh(),
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
                          childAspectRatio: 0.88,
                        ),
                        itemBuilder: (context, index) {
                          final c = list[index];

                          return CategoryCard(
                            image: c.image,
                            name: c.name,
                            slug: c.slug,
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
