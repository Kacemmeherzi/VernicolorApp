
class Product {
  final int id;
  final String productName;
  final String productDescription;
  final double productviab;
  final DateTime productValidatedAt;

  Product({
    required this.id,
    required this.productName,
    required this.productDescription,
    required this.productviab,
    required this.productValidatedAt,
  });

  // Factory constructor for creating a Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      productviab: json['productviab'].toDouble(),
      productValidatedAt: DateTime.parse(json['productValidatedAt']),
    );
  }

  // Method for converting a Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'productDescription': productDescription,
      'productviab': productviab,
      'productValidatedAt': productValidatedAt.toIso8601String(),
    };
  }
}
