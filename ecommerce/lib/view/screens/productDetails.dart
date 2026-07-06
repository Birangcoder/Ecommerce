import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/ProductDetailsProvider.dart';

class productDetails extends ConsumerWidget {
  final String id;

  const productDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailProvider(int.tryParse(id)!));
    return Scaffold(
      appBar: AppBar(title: Text("Product")),
      body: product.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stack) => Center(child: Text(error.toString())),

        data: (product) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.image,
                        width: 350,
                        height: 350,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 40),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 6),
                              Text(product.rating.toString()),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "₹${product.price}",
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text("Brand : ${product.brand}"),
                          const SizedBox(height: 8),
                          Text("Warranty : ${product.warrantyInformation}"),
                          const SizedBox(height: 8),
                          Text("Shipping : ${product.shippingInformation}"),
                          const SizedBox(height: 8),
                          Text("Return Policy : ${product.returnPolicy}"),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                const Divider(),

                const SizedBox(height: 20),

                const Text(
                  "Description",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Text(product.description ?? ""),

                const SizedBox(height: 40),

                const Divider(),

                const SizedBox(height: 20),

                const Text(
                  "Customer Reviews",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: product.reviews!.length,
                  itemBuilder: (context, index) {
                    final review = product.reviews![index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const Icon(Icons.person, size: 40),
                        title: Text(review.reviewerName),
                        subtitle: Text(review.comment),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            Text(review.rating.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
