import 'package:flutter/material.dart';
import 'package:vernicolorapp/views/AddCustomerPage.dart';
import 'package:vernicolorapp/views/AddProductFamilyPage.dart';
import 'package:vernicolorapp/views/CustomerListPage.dart';
import 'package:vernicolorapp/views/ProductFamilyListPage.dart';
import 'package:vernicolorapp/views/ProductListPage.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListPage()),
                );
              },
              child: Text('View Products'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerListPage()),
                );
              },
              child: Text('View Customers'),
            ),
              SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductFamilyListPage()),
                );
              },
              child: Text('View Product families'),
            ),
            
              SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCustomerPage()),
                );
              },
              child: Text('Add a new Customer '),
            ),
              SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductFamilyPage()),
                );
              },
              child: Text('Add a new Product family  '),
            ),
          ],
        ),
      ),
    );
  }
}
