import 'package:flutter/material.dart';
import 'package:vernicolorapp/views/AddCustomerPage.dart';
import 'package:vernicolorapp/views/AddProductFamilyPage.dart';
import 'package:vernicolorapp/views/AddProductPage.dart';
import 'package:vernicolorapp/views/CustomerListPage.dart';
import 'package:vernicolorapp/views/ProductFamilyListPage.dart';
import 'package:vernicolorapp/views/ProductListPage.dart';
import 'package:vernicolorapp/widgets/customButton.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vernicolor App'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('View Products'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('View Customers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerListPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('View Product Families'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductFamilyListPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Add a New Customer'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCustomerPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add_business),
              title: Text('Add a New Product Family'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductFamilyPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add a New Product'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildButton(
              context,
              'View Products',
              Icons.list_alt,
              ProductListPage(),
            ),
            buildButton(
              context,
              'View Customers',
              Icons.people,
              CustomerListPage(),
            ),
            buildButton(
              context,
              'View Product Families',
              Icons.category,
              ProductFamilyListPage(),
            ),
            buildButton(
              context,
              'Add a New Customer',
              Icons.person_add,
              AddCustomerPage(),
            ),
            buildButton(
              context,
              'Add a New Product Family',
              Icons.add_business,
              AddProductFamilyPage(),
            ),
            buildButton(
              context,
              'Add a New Product',
              Icons.add_box,
              AddProductPage(),
            ),
          ],
        ),
      ),
    );
  }

 
}
