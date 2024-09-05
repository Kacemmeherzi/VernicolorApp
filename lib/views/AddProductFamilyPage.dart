import 'package:flutter/material.dart';
import 'package:vernicolorapp/models/Customer.dart';
import 'package:vernicolorapp/models/ProductFamilyDto.dart';
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

  late CustomerService _customerService;
  late ProductFamilyService _productFamilyService;

  @override
  void initState() {
    super.initState();
    _customerService = CustomerService(baseUrl: 'http://10.0.2.2:8082/api/customers'); // Adjust URL
    _productFamilyService = ProductFamilyService(baseUrl: 'http://10.0.2.2:8082/prodfamily'); // Adjust URL
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
          quantity: _quantityController.text.isEmpty ? null : _quantityController.text,
          customerId: _selectedCustomer!.id,
        );

        
      
      try {
        await _productFamilyService.createProductFamily(productFamilyDTO);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product Family added successfully'),backgroundColor: Colors.green,));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add Product Family')));
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
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter a name' : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter a description' : null,
                  ),
                  TextFormField(
                    controller: _quantityController,
                    decoration: InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  CustomerDropdown(onCustomerSelected: _onCustomerSelected),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text('Add Product Family'),
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
