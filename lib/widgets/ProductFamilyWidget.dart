import 'package:flutter/material.dart';
import 'package:vernicolorapp/models/ProductFamily.dart';

class ProductFamilyCard extends StatelessWidget {
  final ProductFamily productFamily;

  const ProductFamilyCard({Key? key, required this.productFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      elevation: 5, // Elevation for shadow effect
      margin: const EdgeInsets.all(10), // Space around the card
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image from assets
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Rounded corners for the image
              child: Image.asset(
                'assets/images/production.png', // Replace with your asset path
                height: 150,
                width: double.infinity,
                fit: BoxFit.scaleDown, // Make the image cover the available space
              ),
            ),
            SizedBox(height: 10), // Space between image and text

            // Product Family Name
            Text(
              productFamily.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent, // Change color as needed
              ),
            ),
            SizedBox(height: 10), // Space between elements

            // Product Family Description
            Text(
              productFamily.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700], // Subtle text color
              ),
            ),

            SizedBox(height: 20), // Space between description and buttons

            // Row for Edit and Delete buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly space the buttons
              children: [
                // Edit Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Edit action
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                  label: Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    minimumSize: Size(120, 40), // Make buttons wider
                  ),
                ),

                // Delete Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Delete action
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Button color
                    minimumSize: Size(120, 40), // Make buttons wider
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Main App
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example ProductFamily object
    ProductFamily sampleProductFamily = ProductFamily(
      id: 1,
      name: 'Electronics',
      description: 'A wide range of consumer electronics including smartphones, laptops, and more.',
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product Family'),
        ),
        body: Center(
          child: ProductFamilyCard(
            productFamily: sampleProductFamily,
          ),
        ),
      ),
    );
  }
}