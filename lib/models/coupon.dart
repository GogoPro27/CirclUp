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

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      description: (map['description'] ?? '') as String,
      photo: (map['photo'] ?? '') as String,
      cost: (map['cost'] ?? 0) as int,
      redeemed: (map['redeemed'] ?? false) as bool,
      qrCode: (map['qrCode'] ?? '') as String,
    );
  }
}
