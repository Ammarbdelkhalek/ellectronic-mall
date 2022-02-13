import 'package:shopapp/models/loginmodel.dart';

abstract class registerstates {}

class initialregisterstate extends registerstates {}

class Successregisterstate extends registerstates {
  final Shoploginmodel? loginmodel;
  Successregisterstate({
    this.loginmodel,
  });
}

class Circleregisterstate extends registerstates {}

class Errorregisterstate extends registerstates {
  final String error;
  Errorregisterstate({required this.error});
}

class changepassstate extends registerstates {}
