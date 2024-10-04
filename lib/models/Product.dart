import 'package:vernicolorapp/models/ProductFamily.dart';
import 'package:vernicolorapp/models/ProductIssue.dart';

class Product {
  final int id;
  final String productName;
  final String productDescription;
  final String? productStatus; // Nullable
  final String? productValidatedAt;
  final String? productCreatedAt; // Nullable
  final ProductFamily productFamily;
  final String? imageUrl ;
  final List<ProductIssue> issues;

  Product({
    required this.id,
    required this.productName,
    required this.productDescription,
    this.productStatus,
    required this.productValidatedAt,
    this.productCreatedAt,
    required this.productFamily,
    required this.issues,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      productStatus: json['productStatus'],
      productValidatedAt: json['productValidatedAt'],
      productCreatedAt: json['productCreatedAt'],
      imageUrl: json['imageUrl'],

      productFamily: ProductFamily.fromJson(json['productFamily']),
      issues: (json['issues'] as List<dynamic>)
          .map((issue) => ProductIssue.fromJson(issue))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'productDescription': productDescription,
      'productStatus': productStatus,
      'productValidatedAt': productValidatedAt,
      'productCreatedAt': productCreatedAt,
      'imageUrl': imageUrl,
      'productFamily': productFamily.toJson(),
      'issues': issues.map((issue) => issue.toJson()).toList(),
    };
  }
}
