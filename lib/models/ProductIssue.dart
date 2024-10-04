class ProductIssue {
  final int id;
  final String type;
  final String description;

  ProductIssue({
    required this.id,
    required this.type,
    required this.description,
  });

  factory ProductIssue.fromJson(Map<String, dynamic> json) {
    return ProductIssue(
      id: json['id'],
      type: json['type'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'description': description,
    };
  }
}
