import 'package:flutter/material.dart';
import 'package:vernicolorapp/models/Product.dart';

class ProductInfoPage extends StatelessWidget {
  final Product product;

  const ProductInfoPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            if (product.imageUrl != null)
              Center(
                child: Image.network(
                  product.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.scaleDown,
                ),
              ),
            SizedBox(height: 16),

            // Product Name
            Text(
             " ${product.productName} ${product.id}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),

            // Product Description
            Text(
              product.productDescription,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Product Status (if available)
            if (product.productStatus != null)
              Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Status: ${product.productStatus}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            SizedBox(height: 8),

            // Product Validation Date (if available)
            if (product.productValidatedAt != null)
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    "Validated At: ${product.productValidatedAt}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            SizedBox(height: 8),

            // Product Creation Date (if available)
            if (product.productCreatedAt != null)
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    "Created At: ${product.productCreatedAt}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            SizedBox(height: 16),

            // Product Family
            Row(
              children: [
                Icon(Icons.category, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  "Product Family: ${product.productFamily.name}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Product Issues (if available)
            if (product.issues.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Issues:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...product.issues.map((issue) {
                    return ListTile(
                      leading: Icon(Icons.warning, color: Colors.red),
                      title: Text(issue.description),
                    );
                  }).toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
