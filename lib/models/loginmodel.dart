class Shoploginmodel {
  bool? status;
  String? message;
  Userdata? data;

  Shoploginmodel({
    this.status,
    this.message,
    this.data,
  });
  Shoploginmodel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Userdata.fromjson(json['data']) : null;
  }
}

class Userdata {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? point;
  int? credit;
  String? token;
  //constractour
  Userdata({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.point,
    this.credit,
    this.token,
  });

  //named constructor

  Userdata.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    point = json['point'];
    credit = json['credit'];
    token = json['token'];
  }
}
