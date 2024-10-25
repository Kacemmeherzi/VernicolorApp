import 'package:flutter/material.dart';
import 'package:vernicolorapp/models/Customer.dart';
import 'package:vernicolorapp/services/CustomerService.dart';

class CustomerDropdown extends StatefulWidget {
  final void Function(Customer?) onCustomerSelected;

  CustomerDropdown({required this.onCustomerSelected});

  @override
  _CustomerDropdownState createState() => _CustomerDropdownState();
}

class _CustomerDropdownState extends State<CustomerDropdown> {
  List<Customer> _customers = [];
  Customer? _selectedCustomer;

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    try {
      final customerService = CustomerService();
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

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Customer>(
      value: _selectedCustomer,
      hint: Text('Select Customer'),
      onChanged: (Customer? newValue) {
        setState(() {
          _selectedCustomer = newValue;
        });
        widget.onCustomerSelected(newValue);
      },
      items: _customers.map((Customer customer) {
        return DropdownMenuItem<Customer>(
          value: customer,
          child: Text(customer.customerName),
        );
      }).toList(),
    );
  }
}
