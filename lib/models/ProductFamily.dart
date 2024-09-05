// product_family.dart
class ProductFamily {
  final int id;
  final String name;
  final String description;
  //final String quantity;

  ProductFamily({
    required this.id,
    required this.name,
    required this.description,
   // required this.quantity,
  });

  factory ProductFamily.fromJson(Map<String, dynamic> json) {
    return ProductFamily(
      id: json['id'],
      name: json['name'],
      description: json['description'],
     // quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
     // 'quantity': quantity,
    };
  }
}
