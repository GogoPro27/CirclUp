import 'package:flutter/material.dart';
import '../models/coupon.dart';

class CouponDetailsBottomSheet extends StatelessWidget {
  final Coupon coupon;
  final VoidCallback onRedeem;

  const CouponDetailsBottomSheet({
    Key? key,
    required this.coupon,
    required this.onRedeem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(coupon.photo, height: 100),
          const SizedBox(height: 16),
          Text(
            coupon.description,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text('Spend', style: TextStyle(color: Colors.grey)),
                  Text('${coupon.cost} 🪙', style: const TextStyle(color: Colors.orange)),
                ],
              ),
              Column(
                children: [
                  const Text('Earn', style: TextStyle(color: Colors.grey)),
                  const Text('50 🪙', style: TextStyle(color: Colors.orange)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRedeem, // Call the redeem logic
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text('Use ${coupon.cost} circles'),
          ),
        ],
      ),
    );
  }
}