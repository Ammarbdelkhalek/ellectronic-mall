class Categorymodel {
  bool? status;
  Categorydata? data;
  Categorymodel({
    this.status,
    this.data,
  });
  Categorymodel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = Categorydata.fromjson(json['data']);
  }
}

class Categorydata {
  List<Getcategorydata>? data = [];
  int? current_page;

  Categorydata({this.data, this.current_page});

  Categorydata.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];

    json['data'].forEach((element) {
      data!.add(Getcategorydata.fromjson(element));
    });
  }
}

class Getcategorydata {
  int? id;
  String? name;
  String? image;
  Getcategorydata.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
