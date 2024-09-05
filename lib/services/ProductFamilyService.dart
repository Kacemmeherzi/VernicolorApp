// product_family_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vernicolorapp/models/ProductFamily.dart';
import 'package:vernicolorapp/models/ProductFamilyDto.dart';

class ProductFamilyService {
  final String baseUrl;

  ProductFamilyService({required this.baseUrl});

  Future<List<ProductFamily>> getProductFamilies() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductFamily.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load product families');
    }
  }

  Future<ProductFamily> getProductFamily(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/productfamilies/$id'));
    if (response.statusCode == 200) {
      return ProductFamily.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product family');
    }
  }

  Future<void> createProductFamily(ProductFamilyDTO productFamilyDTO) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(productFamilyDTO.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create product family');
    }
  }

  Future<void> updateProductFamily(ProductFamily productFamily) async {
    final response = await http.put(
      Uri.parse('$baseUrl/productfamilies/${productFamily.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(productFamily.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product family');
    }
  }

  Future<void> deleteProductFamily(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/productfamilies/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product family');
    }
  }
}
