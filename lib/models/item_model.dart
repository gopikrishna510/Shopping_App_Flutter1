class ItemModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ItemModel(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.image,
        this.rating});

  ItemModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<dynamic, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}
