class ProductFamilyDTO {
  final String name;
  final String description;
  final String? quantity;
  final int customerId;

  ProductFamilyDTO({
    required this.name,
    required this.description,
    this.quantity,
    required this.customerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'customerid': customerId,
    };
  }

  factory ProductFamilyDTO.fromJson(Map<String, dynamic> json) {
    return ProductFamilyDTO(
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      customerId: json['customerid'],
    );
  }
}
