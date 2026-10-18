import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // for date formatting — add intl to pubspec if not present

import '../../data/model/OrderItem.dart';
import '../provider/orderRepositoryProvider.dart';

class MyOrderScreen extends ConsumerWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(orderNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Failed to load orders: $e")),
        data: (orders) {
          if (orders.isEmpty) {
            return const Center(
              child: Text(
                "No orders yet",
                style: TextStyle(fontSize: 16, color: Color(0xFF6a7282)),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(orderNotifierProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return OrderCard(order: orders[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderItem order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFFFF),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Color(0xFF6a7282),
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                  DateFormat('dd MMM yyyy, hh:mm a').format(order.orderedAt),
                  style: const TextStyle(
                    color: Color(0xFF6a7282),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),

              ],
            ),
            const SizedBox(height: 6),
            const Divider(),
            const SizedBox(height: 6),
            Row(
              children: [
                // NOTE: OrderItem has no product image — placeholder icon shown.
                // If you fetch product details via order.productId, swap this
                // for Image.network(product.image).
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 85,
                  width: 85,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      order.thumbnail!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.shopping_bag_outlined,
                        color: Color(0xFFCA8A04),
                        size: 34,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF101828),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Qty: ${order.quantity}",
                        style: const TextStyle(
                          color: Color(0xFF6a7282),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹${order.total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Color(0xFF2d5f3f),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.payment_outlined,
                  color: Color(0xFF6B717D),
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  "Paid via ${order.paymentMethod}",
                  style: const TextStyle(
                    color: Color(0xFF364153),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFFFFFFFF),
                  backgroundColor: const Color(0xFF2d5f3f),
                  fixedSize: const Size(80, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => OrderDetails(order: order),
                  //   ),
                  // );
                },
                child: const Text(
                  "View Details",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
