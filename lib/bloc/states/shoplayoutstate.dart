import 'package:shopapp/models/faviouritemodel.dart';
import 'package:shopapp/models/loginmodel.dart';
import 'package:shopapp/models/profilemodel.dart';

abstract class Shoplayoutstates {}

class Initialshoplayoutstate extends Shoplayoutstates {}

class Changenavstate extends Shoplayoutstates {}

class Shoploadingstate extends Shoplayoutstates {}

class Shopsuccessstate extends Shoplayoutstates {}

class Shoperrorstate extends Shoplayoutstates {
  final String? error;
  Shoperrorstate({this.error});
}

class Categoryloadingstate extends Shoplayoutstates {}

class Categorysuccessstate extends Shoplayoutstates {}

class Categoryerrorstate extends Shoplayoutstates {
  final String? error;
  Categoryerrorstate({this.error});
}

class Changefaviourtsuccessstate extends Shoplayoutstates {
  final Changefavouritmodel? model;
  Changefaviourtsuccessstate({this.model});
}

class changefaviourtestats extends Shoplayoutstates {}

class Changefaviourterrorstate extends Shoplayoutstates {
  final String? error;

  Changefaviourterrorstate({
    this.error,
  });
}

class Favoriteloadingstate extends Shoplayoutstates {}

class Favoritesuccessstate extends Shoplayoutstates {}

class Favoriteerrorstate extends Shoplayoutstates {
  final String? error;
  Favoriteerrorstate({this.error});
}

class profileloadingstate extends Shoplayoutstates {}

class profilesuccessstate extends Shoplayoutstates {
  profilemodel? getprofile;
  profilesuccessstate({this.getprofile});
}

class profileerrorstate extends Shoplayoutstates {
  final String? error;
  profileerrorstate({this.error});
}

class Successupdatestate extends Shoplayoutstates {
  final Shoploginmodel? updateusermodel;
  Successupdatestate({
    this.updateusermodel,
  });
}

class Circleupdatestate extends Shoplayoutstates {}

class Errorupdatestate extends Shoplayoutstates {
  final String error;
  Errorupdatestate({required this.error});
}
