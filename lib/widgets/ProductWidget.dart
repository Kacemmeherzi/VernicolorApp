import 'package:flutter/material.dart';
import 'package:vernicolorapp/models/Product.dart';
import 'package:vernicolorapp/views/AddProductIssue.dart';
import 'package:vernicolorapp/views/ProductInfoPage.dart';

class ProductWidget extends StatelessWidget {
   final Product product  ;
  const ProductWidget({
    required this.product ,
    Key? key,
   
  }) : super(key: key);
 



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Product Image or Placeholder if imageUrl is null or empty
            product.imageUrl != null && product.imageUrl!.isNotEmpty
                ? Image.network(
                    product.imageUrl!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.scaleDown,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.png', // Add your local placeholder image
                        height: 50,
                        width: double.infinity,
                        fit: BoxFit.scaleDown,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/placeholder.png', // Default placeholder image
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.scaleDown,
                  ),
            const SizedBox(height: 10),

            // Display Product Name
            Text(
              product.productName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),

            // Display Product Description
            Text(
              product.productDescription,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.productFamily.name,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.productCreatedAt??"",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.productValidatedAt??"No issues added",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
            "Issues found  ${product.issues.length.toString()}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            // Display Product Status: Good if issues > 0, Bad if issues == 0
            Text(
              product.issues.isEmpty ? "Good" : "Bad",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: product.issues.isEmpty ? Colors.green : Colors.red,
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children :[
               ElevatedButton(  style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 40), backgroundColor: Colors.blue,foregroundColor: Colors.black
          ),
                onPressed:(){  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductInfoPage(product: product),
    ),
  );}, child: Text("view product info ")),ElevatedButton(  style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 40), backgroundColor: Colors.red,foregroundColor: Colors.black
          ),
                onPressed:(){ Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => AddProductIssue(productId: product.id)));}, child: Text("add an issue "))
            ],)
           
          ],

        ),
      ),
    );
  }
}
