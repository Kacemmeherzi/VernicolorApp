import 'package:flutter/material.dart';
import 'package:vernicolorapp/models/Product.dart';
import 'package:vernicolorapp/services/ProductService.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductService productService;
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    productService = ProductService(baseUrl: 'http://10.0.2.2:8082/api/products'); // Adjust the URL
    futureProducts = productService.getProducts();
  }
  Future<void> _refreshData() async {
    setState(() {
      futureProducts = productService.getProducts(); // Refresh the data
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        backgroundColor:Colors.red,
      ),
      body:RefreshIndicator(
        onRefresh: _refreshData, // Callback for refresh
        child: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Image section
                        Image.network(
                         // product.imageUrl ?? 
                         'https://via.placeholder.com/150', // Use a placeholder if no image URL
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(Icons.error, color: Colors.red),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.productName,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(product.productDescription),
                              SizedBox(height: 8),
                              Text(
                                product.productValidatedAt.toString(),
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
    ));
  }
}
