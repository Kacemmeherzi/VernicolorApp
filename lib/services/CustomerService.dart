import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vernicolorapp/config/config.dart';
import 'package:vernicolorapp/models/Customer.dart';

class CustomerService {
  final String baseUrl= "${Config.apiUrlDev}/api/customers" ; 


  Future<List<Customer>> getCustomers() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((data) => Customer.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

  Future<Customer> getCustomer(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/customers/$id'));

    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load customer');
    }
  }

  Future<void> createCustomer(Customer customer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(customer.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create customer');
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    final response = await http.put(
      Uri.parse('$baseUrl/customers/${customer.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(customer.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update customer');
    }
  }

  Future<void> deleteCustomer(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/customers/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete customer');
    }
  }
}
