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
                ref.read(wishlistNotifierProvider.notifier).toggle(
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
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.image,
                      width: screenWidth - 32,
                      height: screenWidth - 32,
                      fit: BoxFit.cover,
                    ),
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
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 6),
                        Text(product.rating.toString()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "₹${product.price}",
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("Brand : ${product.brand}"),
                    const SizedBox(height: 8),
                    Text("Warranty : ${product.warrantyInformation}"),
                    const SizedBox(height: 8),
                    Text("Shipping : ${product.shippingInformation}"),
                    const SizedBox(height: 8),
                    Text("Return Policy : ${product.returnPolicy}"),
                  ],
                ),

                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),

                const Text(
                  "Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(product.description ?? ""),

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

                const SizedBox(height: 100), // leave room so bottom bar doesn't cover content
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
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(cartNotifierProvider.notifier).addToCart(
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}