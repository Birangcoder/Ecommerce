import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/CartItem.dart';
import '../../models/WishlistItem.dart';
import '../../providers/ProductDetailsProvider.dart';
import '../../providers/cartRepositoryProvider.dart';
import '../../providers/wishlistRepositoryProvider.dart';

class ProductDetails extends ConsumerWidget {
  final String id;

  const ProductDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productId = int.tryParse(id)!;
    final product = ref.watch(productDetailProvider(productId));
    final screenWidth = MediaQuery.of(context).size.width;

    // watch wishlist state so the heart icon updates reactively
    final wishlistAsync = ref.watch(wishlistNotifierProvider);
    final isWishlisted = wishlistAsync.maybeWhen(
      data: (list) => list.any((w) => w.productId == productId),
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        actions: [
          product.maybeWhen(
            data: (p) => IconButton(
              icon: Icon(
                isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: isWishlisted ? Colors.red : null,
              ),
              onPressed: () {
                ref
                    .read(wishlistNotifierProvider.notifier)
                    .toggle(
                      WishlistItem(
                        productId: p.id,
                        title: p.name,
                        price: p.price,
                        rating: p.rating,
                        thumbnail: p.image,
                      ),
                    );
              },
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: product.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
        data: (product) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 320,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(product.image, fit: BoxFit.contain),
                  ),
                ),

                const SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 18, color: Colors.orange),
                          SizedBox(width: 4),
                          Text(product.rating.toString()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹${product.price}",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          "Inclusive of all taxes",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          infoRow(Icons.store, "Brand", "${product.brand}"),
                          Divider(),
                          infoRow(
                            Icons.local_shipping,
                            "Shipping",
                            "${product.shippingInformation}",
                          ),
                          Divider(),
                          infoRow(
                            Icons.verified,
                            "Warranty",
                            "${product.warrantyInformation}",
                          ),
                          Divider(),
                          infoRow(
                            Icons.assignment_return,
                            "Return",
                            "${product.returnPolicy}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(product.description ?? ""),
                      const SizedBox(height: 12),
                      Text(product.description ?? ""),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),

                const Text(
                  "Customer Reviews",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: product.reviews!.length,
                  itemBuilder: (context, index) {
                    final review = product.reviews![index];
                    return Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.reviewerName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: List.generate(
                                review.rating,
                                (_) => Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(review.comment),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 100),
                // leave room so bottom bar doesn't cover content
              ],
            ),
          );
        },
      ),

      // 🛒 ADD TO CART bottom bar
      bottomNavigationBar: product.maybeWhen(
        data: (p) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "₹${p.price}",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .addToCart(
                              CartItem(
                                productId: p.id,
                                title: p.name,
                                price: p.price,
                                quantity: 1,
                                total: p.price,
                                thumbnail: p.image,
                              ),
                            );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to cart")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2d5f3f),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}

Widget infoRow(IconData icon, String title, String value) {
  return Row(
    children: [
      Icon(icon, color: Colors.green),
      SizedBox(width: 12),
      Text("$title : ", style: TextStyle(fontWeight: FontWeight.bold)),
      Expanded(child: Text(value)),
    ],
  );
}
