class ProductModel {
  final int id;
  final String title;
  final String description;
  final num price;
  final String image;
  final String category;
  final Rating rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      category: json['category'],
      rating: Rating.fromJson(json['rating']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'rating': rating.toJson(),
    };
  }
}

class Rating {
  final int count;
  final num rate;

  Rating({required this.count, required this.rate});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      count: json['count'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'rate': rate,
    };
  }
}
