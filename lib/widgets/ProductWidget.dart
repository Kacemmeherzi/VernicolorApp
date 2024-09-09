import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final String? imageUrl;  // Nullable to handle absence of an image
  final String name;
  final String description;
  final List<String> issues;

  const ProductWidget({
    Key? key,
    this.imageUrl,
    required this.name,
    required this.description,
    required this.issues,
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
            imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
                    imageUrl!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/placeholder.png', // Add your local placeholder image
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/placeholder.png', // Default placeholder image
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 10),

            // Display Product Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),

            // Display Product Description
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            // Display Product Status: Good if issues > 0, Bad if issues == 0
            Text(
              issues.isNotEmpty ? "Good" : "Bad",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: issues.isNotEmpty ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
