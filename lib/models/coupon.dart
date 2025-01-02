class Coupon {
  final String description;
  final String photo;
  final int cost;
  bool redeemed;
  final String qrCode;

  Coupon({
    required this.description,
    required this.photo,
    required this.cost,
    this.redeemed = false,
    required this.qrCode,
  });
}