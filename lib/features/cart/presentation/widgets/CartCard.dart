import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/CartItem.dart';
import '../provider/cartRepositoryProvider.dart';

class CartCard extends ConsumerWidget {
  final CartItem item;

  const CartCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cartNotifierProvider.notifier);

    return Card(
      color: const Color(0xFFFFFFFF),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E6),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 85,
              width: 85,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: item.thumbnail != null
                    ? Image.network(item.thumbnail!)
                    : const Icon(Icons.image_not_supported),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            color: Color(0xFF1a1a1a),
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () => notifier.removeFromCart(item.id!),
                        icon: const Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "₹${item.price}",
                        style: const TextStyle(
                          color: Color(0xFF2d5f3f),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      _qtyButton(
                        Icons.remove,
                        item.quantity > 1
                            ? () => notifier.updateQuantity(
                                item,
                                item.quantity - 1,
                              )
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.quantity.toString(),
                        style: const TextStyle(
                          color: Color(0xFF1a1a1a),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _qtyButton(
                        Icons.add,
                        () => notifier.updateQuantity(item, item.quantity + 1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _qtyButton(IconData icon, VoidCallback? onTap) {
  return Opacity(
    opacity: onTap == null ? 0.4 : 1,
    child: Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Icon(icon, size: 18),
      ),
    ),
  );
}
