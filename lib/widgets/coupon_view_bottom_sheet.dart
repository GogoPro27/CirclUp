import 'package:flutter/material.dart';
import '../models/coupon.dart';

class CouponViewBottomSheet extends StatelessWidget {
  final Coupon coupon;

  const CouponViewBottomSheet({Key? key, required this.coupon}) : super(key: key);

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
          const SizedBox(height: 16),
          Image.asset(coupon.qrCode, height: 150),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}