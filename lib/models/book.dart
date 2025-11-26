class Book {
  final int? id;
  final String name;
  final int price;
  final String image;

  const Book(this.name, this.price, this.image, {this.id});

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'image': image};
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(map['name'], map['price'], map['image'], id: map['id']);
  }
}
