class Homemodel {
  bool? status;
  Getdata? data;

  Homemodel({
    this.status,
    this.data,
  });
  Homemodel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = Getdata.fromjson(json['data']);
  }
}

class Getdata {
  List<Bannermodel> banners = [];
  List<Productmodel> products = [];

  Getdata.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      (banners.add(Bannermodel.fromjson(element)));
    });

    json['products'].forEach((element) {
      (products.add(Productmodel.fromjson(element)));
    });
  }
}

class Bannermodel {
  int? id;
  String? image;
  Bannermodel({
    this.id,
    this.image,
  });
  Bannermodel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Productmodel {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? name;
  String? image;
  String? description;
  bool? in_favorites;
  bool? in_cart;

  Productmodel({
    this.id,
    this.price,
    this.old_price,
    this.discount,
    this.name,
    this.image,
    this.description,
  });

  Productmodel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
