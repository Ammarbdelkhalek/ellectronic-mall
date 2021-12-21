import 'package:shopapp/models/loginmodel.dart';

abstract class Apploginstates {}

class Initialstate extends Apploginstates {}

class Successloginstate extends Apploginstates {
  final Shoploginmodel? loginmodel;
  Successloginstate({
    this.loginmodel,
  });
}

class Circleloginstate extends Apploginstates {}

class Errorloginstate extends Apploginstates {
  final String error;
  Errorloginstate({required this.error});
}

class Changevisiblestates extends Apploginstates {}
