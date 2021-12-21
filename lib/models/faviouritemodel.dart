class Changefavouritmodel {
  bool? status;
  String? message;
  Changefavouritmodel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
