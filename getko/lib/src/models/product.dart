class Product {
  String image;
  String name;
  String description;
  double price;
  String? url;
  String? id;
  String? quantity;

  Product(this.image, this.name, this.description, this.price,
      [this.url, this.id, this.quantity]);

  @override
  String toString() {
    return '$name/$price/$url/$id';
  }
}
