import 'package:ecommerce/config/routeNameConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/cartRepositoryProvider.dart';
import '../widgets/CartCard.dart';

class Carts extends ConsumerWidget {
  const Carts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: cartAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Error: $e")),
        data: (cartList) {
          if (cartList.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("No Cart Item Found"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => context.goNamed(AppRoute.home),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2d5f3f),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text("Continue Shopping"),
                  ),
                ],
              ),
            );
          }

          // ---- bill calculations derived from real cart data ----
          final itemTotal = cartList.fold<double>(
            0,
                (sum, item) => sum + item.total,
          );
          const deliveryFee = 30.0; // replace with your real logic/config
          final toPay = itemTotal + deliveryFee;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    final item = cartList[index];

                    return CartCard(
                      key: ValueKey(item.id),
                      item: item,
                    );
                  },
                ),

                const SizedBox(height: 15),

                Card(
                  color: const Color(0xFFFFFFFF),
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bill Details",
                          style: TextStyle(
                            color: Color(0xFF101828),
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 6),
                        rowText("Item Total", itemTotal),
                        rowText("Delivery Fee", deliveryFee),
                        const Divider(),
                        rowText("To Pay", toPay, isBold: true, isFinal: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: cartAsync.maybeWhen(
        data: (cartList) {
          if (cartList.isEmpty) return const SizedBox.shrink();

          final itemTotal = cartList.fold<double>(0, (s, i) => s + i.total);
          const deliveryFee = 30.0;
          final toPay = itemTotal + deliveryFee;

          return Container(
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "₹${toPay.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Color(0xFF2d5f3f),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: navigate to checkout, then call
                        // ref.read(orderNotifierProvider.notifier).placeOrder(...)
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2d5f3f),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.shopping_cart_checkout, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Checkout",
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
          );
        },
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }

  Widget rowText(
      String title,
      double value, {
        bool isBold = false,
        bool isFinal = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isFinal ? FontWeight.w700 : FontWeight.normal,
              fontSize: isFinal ? 16 : 14,
            ),
          ),
          const Spacer(),
          Text(
            "₹${value.toStringAsFixed(2)}",
            style: TextStyle(
              color: isFinal ? const Color(0xFF2d5f3f) : const Color(0xFF101010),
              fontWeight: FontWeight.w700,
              fontSize: isFinal ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}