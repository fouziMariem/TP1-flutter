class Book {
  final int? id;
  final String name;
  final int price;
  final String image;
  final int quantity;

  const Book(this.name, this.price, this.image, {this.id, this.quantity = 1});

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'image': image, 'quantity': quantity};
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      map['name'],
      map['price'],
      map['image'],
      id: map['id'],
      quantity: map['quantity'] ?? 1,
    );
  }
}
