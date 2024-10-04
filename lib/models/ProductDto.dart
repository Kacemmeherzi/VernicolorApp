class ProductDTO {
  final String productName;
  final String productDescription;
  final String  productStatus;
  final int productFamily;

  ProductDTO({
    required this.productName,
    required this.productDescription,
    required this.productStatus,
    required this.productFamily,
  });

  // Method to convert ProductDTO to JSON
  Map<String, dynamic> toJson() {
    return {
      "productName": productName,
      "productDescription": productDescription,
      "productStatus": productStatus, 
      "productFamily": productFamily,
    };
  }
}
