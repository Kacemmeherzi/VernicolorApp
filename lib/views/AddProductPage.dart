import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:vernicolorapp/models/ProductFamily.dart';
import 'package:vernicolorapp/services/ProductFamilyService.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String? _productId;
  String? _productName;
  String? _productDescription;
  String? _productStatus;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _selectedProductFamily;
  List<ProductFamily> _productFamilies = [];
  late ProductFamilyService _productFamilyService;
  @override
  void initState() {
    super.initState();
    _productFamilyService = new ProductFamilyService();
    _fetchProductFamilies();
  }

  Future<void> _fetchProductFamilies() async {
    try {
      List<ProductFamily> families =
          await _productFamilyService.getProductFamilies();
      setState(() {
        _productFamilies = families;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load product families')),
      );
    }
  }

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // Method to post the product with image to the server
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Make sure image is selected
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please pick an image')),
        );
        return;
      }

      // Create a multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://10.0.2.2:8082/api/products/createp'), // Update with your API endpoint
      );

      // Add fields for product name and description
      request.fields['name'] = _productName!;
      request.fields['status'] = _productStatus!;
      request.fields['description'] = _productDescription!;
      request.fields['prodfamily'] = _selectedProductFamily!;

      // Attach image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          _image!.path,
        ),
      );

      // Send request
      var response = await request.send();

      // Handle response
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Product')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.scaleDown)
                          : Icon(Icons.add_a_photo,
                              color: Colors.grey, size: 50),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Product ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product id';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _productId = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Button action
                    },
                    icon: Icon(Icons.qr_code), // Add icon
                    label: Text('Scan QR code'), // Button label
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10), // Button height
                        textStyle: TextStyle(fontSize: 16),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Product Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _productName = value;
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Product Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _productDescription = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Product Status'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product status';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _productStatus = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Product Family'),
                    value: _selectedProductFamily,
                    items: _productFamilies.map((family) {
                      return DropdownMenuItem(
                        value: family.id.toString(),
                        child: Text(family.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProductFamily = value as String?;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a product family';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    label: Text("Add Product"),
                    icon: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 25), // Button height
                        textStyle: TextStyle(fontSize: 16),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black),
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
