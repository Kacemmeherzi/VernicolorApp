import 'package:flutter/material.dart';
import 'package:vernicolorapp/models/Customer.dart';
import 'package:vernicolorapp/models/ProductFamilyDto.dart';
import 'package:vernicolorapp/services/AuthService.dart';
import 'package:vernicolorapp/services/CustomerService.dart';
import 'package:vernicolorapp/services/ProductFamilyService.dart';
import 'package:vernicolorapp/views/CustomerDropDown.dart';

class AddProductFamilyPage extends StatefulWidget {
  @override
  _AddProductFamilyPageState createState() => _AddProductFamilyPageState();
}

class _AddProductFamilyPageState extends State<AddProductFamilyPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  Customer? _selectedCustomer;
  List<Customer> _customers = [];

  late CustomerService _customerService;
  late ProductFamilyService _productFamilyService;

  @override
  void initState() {
    super.initState();
    _productFamilyService = ProductFamilyService();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    try {
      final customerService = CustomerService(); // Adjust URL
      final customers = await customerService.getCustomers();
      setState(() {
        _customers = customers;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load customers')),
      );
    }
  }

  void _onCustomerSelected(Customer? customer) {
    setState(() {
      _selectedCustomer = customer;
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final productFamilyDTO = ProductFamilyDTO(
        name: _nameController.text,
        description: _descriptionController.text,
        quantity:
            _quantityController.text.isEmpty ? null : _quantityController.text,
        customerId: _selectedCustomer!.id,
      );

      try {
        await _productFamilyService.createProductFamily(productFamilyDTO);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Product Family added successfully'),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add Product Family')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product Family'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter a name' : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter a description'
                        : null,
                  ),
                  TextFormField(
                    controller: _quantityController,
                    decoration: InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<Customer>(
                    value: _selectedCustomer,
                    hint: Text('Select a customer'),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCustomer = newValue!;
                      });
                    },
                    items: _customers.map((customer) {
                      return DropdownMenuItem<Customer>(
                        value: customer,
                        child: Text(customer.customerName),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a customer';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    label: Text("Add Product Family"),
                    icon: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 25), // Button height
                        textStyle: TextStyle(fontSize: 16),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black),
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
