
class Customer {
  final int id;
  final String customerName;
  final String customerEmail;
  final String customerSerialNumber;

  Customer({
    required this.id,
    required this.customerName,
    required this.customerEmail,
    required this.customerSerialNumber,
  });

  // Factory constructor for creating a Customer instance from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      customerName: json['custumerName'],
      customerEmail: json['custumerEmail'],
      customerSerialNumber: json['custumerSerialNumber'],
    );
  }

  // Method for converting a Customer instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'custumerName': customerName,
      'custumerEmail': customerEmail,
      'custumerSerialNumber': customerSerialNumber,
    };
  }
}
