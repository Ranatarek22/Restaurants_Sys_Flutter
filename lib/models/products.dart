class Product {
  final String id;
  final String name;
  final int price;

  Product({required this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    String id = json['id'] ?? '';
    String name = json['name'] ?? '';
    int price = 0;

    // Try parsing the price field as an int, catch any errors
    try {
      price = json['price'] as int;
    } catch (e) {
      // Handle the error, you can log it or set a default value
      print('Error parsing price: $e');
    }

    return Product(id: id, name: name, price: price);
  }
}
