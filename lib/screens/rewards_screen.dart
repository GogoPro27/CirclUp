import 'package:flutter/material.dart';
import '../models/coupon.dart';
import '../data/data.dart';
import '../widgets/coupon_details_bottom_sheet.dart';
import '../widgets/coupon_view_bottom_sheet.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  bool isRedeemTab = true;

  void redeemCoupon(Coupon coupon) {
    final user = mockUsers[0]; // Assuming the first user is the active user

    if (user.coins >= coupon.cost) {
      setState(() {
        user.coins -= coupon.cost; // Deduct the coins
        coupon.redeemed = true;    // Mark the coupon as redeemed
      });
      Navigator.pop(context); // Close the bottom sheet
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Coupon redeemed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      Navigator.pop(context); // Close the bottom sheet
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Insufficient funds to redeem this coupon.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = mockUsers[0]; // Get the active user
    final redeemableCoupons = mockCoupons.where((c) => !c.redeemed).toList();
    final redeemedCoupons = mockCoupons.where((c) => c.redeemed).toList();
    final coupons = isRedeemTab ? redeemableCoupons : redeemedCoupons;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text('Current circles', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const Spacer(),
            Text('${user.coins} 🪙', style: const TextStyle(fontSize: 24, color: Colors.orange)),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => setState(() => isRedeemTab = true),
                child: Text('Redeem',
                    style: TextStyle(
                      color: isRedeemTab ? Colors.orange : Colors.grey,
                      fontWeight: isRedeemTab ? FontWeight.bold : FontWeight.normal,
                    )),
              ),
              TextButton(
                onPressed: () => setState(() => isRedeemTab = false),
                child: Text('History',
                    style: TextStyle(
                      color: !isRedeemTab ? Colors.orange : Colors.grey,
                      fontWeight: !isRedeemTab ? FontWeight.bold : FontWeight.normal,
                    )),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: coupons.length,
              itemBuilder: (context, index) {
                final coupon = coupons[index];
                return ListTile(
                  leading: Image.asset(coupon.photo, width: 50, height: 50),
                  title: Text(coupon.description),
                  trailing: isRedeemTab
                      ? Text('${coupon.cost} 🪙', style: const TextStyle(color: Colors.orange))
                      : TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) => CouponViewBottomSheet(coupon: coupon),
                            );
                          },
                          child: const Text('View', style: TextStyle(color: Colors.orange)),
                        ),
                  onTap: isRedeemTab
                      ? () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => CouponDetailsBottomSheet(
                              coupon: coupon,
                              onRedeem: () => redeemCoupon(coupon),
                            ),
                          );
                        }
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}