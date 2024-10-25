import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vernicolorapp/config/config.dart';
import 'package:vernicolorapp/models/Product.dart';
import 'package:vernicolorapp/models/ProductDto.dart';

class ProductService {
  final String baseUrl= "${Config.apiUrlDev}/api/products";


  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> getProduct(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

 Future<void> createProduct(ProductDTO productDTO) async {
  final url = Uri.parse('$baseUrl/create');

  // Prepare the request body using the ProductDTO's toJson() method
  final body = jsonEncode(productDTO.toJson());

  try {
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    if (response.statusCode == 201) {
      // Successfully created the product
      print('Product created successfully');
    } else {
      print('Failed to create product: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}


  Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/${product.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}
