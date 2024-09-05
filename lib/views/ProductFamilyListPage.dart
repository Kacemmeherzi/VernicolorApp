// product_family_list_page.dart
import 'package:flutter/material.dart';
import 'package:vernicolorapp/models/ProductFamily.dart';
import 'package:vernicolorapp/services/ProductFamilyService.dart';

class ProductFamilyListPage extends StatefulWidget {
  @override
  _ProductFamilyListPageState createState() => _ProductFamilyListPageState();
}

class _ProductFamilyListPageState extends State<ProductFamilyListPage> {
  late ProductFamilyService productFamilyService;
  late Future<List<ProductFamily>> productFamilies;

  @override
  void initState() {
    super.initState();
    productFamilyService = ProductFamilyService(baseUrl: 'http://10.0.2.2:8082/prodfamily'); // Adjust URL
    productFamilies = productFamilyService.getProductFamilies();
  }
   Future<void> _refreshData() async {
    setState(() {
      productFamilies = productFamilyService.getProductFamilies(); // Refresh the data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Families'),
      ),
      body: RefreshIndicator(onRefresh: _refreshData,child: 
      FutureBuilder<List<ProductFamily>>(
        future: productFamilies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No product families found'));
          } else {
            List<ProductFamily> productFamilies = snapshot.data!;
            return ListView.builder(
              itemCount: productFamilies.length,
              itemBuilder: (context, index) {
                final productFamily = productFamilies[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Image holder (optional)
                        Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey,
                          child: Icon(Icons.category, color: Colors.white),
                        ),
                        SizedBox(width: 16),
                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Family name : ${productFamily.name}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(productFamily.description),
                              Text('z',
                                //'Quantity: ${productFamily.quantity}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    ));
  }
}
