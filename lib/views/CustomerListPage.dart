import 'package:flutter/material.dart';
import 'package:vernicolorapp/models/Customer.dart';
import 'package:vernicolorapp/services/CustomerService.dart';

class CustomerListPage extends StatefulWidget {
  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  late CustomerService customerService;
  late Future<List<Customer>> customers;

  @override
  void initState() {
    super.initState();
    customerService = CustomerService(baseUrl: 'http://10.0.2.2:8082/api/customers'); // Adjust URL
    customers = customerService.getCustomers();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
      ),
      body: FutureBuilder<List<Customer>>(
        future: customers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No customers found'));
          } else {
            List<Customer> customers = snapshot.data!;
            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Image section
                      Image.asset(
            'assets/images/customer.png',
            width: double.infinity,
            height: 200.0,
            fit: BoxFit.scaleDown, // Adjust how the image fits within the space
          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(customer.customerName,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(customer.customerEmail),
                              SizedBox(height: 8),
                              Text(
                                customer.customerSerialNumber,
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ],
                        ),
                        ),
                        Center(
                          child: 
                        OverflowBar(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              child: Text('Edit'),
                          
                        ), ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              child: Text('delete'),
                          
                        )]),
            )]));}
              
            );
          }
        },
      ),
    );
  }
}