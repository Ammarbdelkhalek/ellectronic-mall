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

class Changefaviourtsuccessstate extends Shoplayoutstates {}

class Changefaviourterrorstate extends Shoplayoutstates {
  final String? error;
  Changefaviourterrorstate({this.error});
}
