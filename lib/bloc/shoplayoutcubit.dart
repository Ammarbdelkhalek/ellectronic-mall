import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/states/shoplayoutstate.dart';
import 'package:shopapp/models/categorymodel.dart';
import 'package:shopapp/models/faviouritemodel.dart';
import 'package:shopapp/models/homemmodel.dart';
import 'package:shopapp/screen/catergory.dart';
import 'package:shopapp/screen/favourit.dart';
import 'package:shopapp/screen/home.dart';
import 'package:shopapp/screen/setting.dart';
import 'package:shopapp/shared/constance.dart';
import 'package:shopapp/shared/network/local.dart';

class Shoplayoutcubit extends Cubit<Shoplayoutstates> {
  Shoplayoutcubit() : super(Initialshoplayoutstate());
  static Shoplayoutcubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<BottomNavigationBarItem> navigation = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category_outlined),
      label: 'category',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border_outlined),
      label: 'favorite',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  List<Widget> layouts = const [Home(), category(), faviourit(), setting()];

  void changenavbar(index) {
    currentindex = index;
    emit(Changenavstate());
  }

  Homemodel? homemodel;
  Map<int, bool> favoruit = {};

  void homedata() {
    emit(Shoploadingstate());
    Diohleper.getdate(
            url: 'https://student.valuxapps.com/api/home', token: token)
        .then((value) {
      homemodel = Homemodel.fromjson(value.data);
      printFullText(homemodel!.data!.banners[0].image!);
      print(homemodel!.status);
      homemodel!.data!.products.forEach((element) {
        favoruit.addAll({element.id!: element.in_favorites!});
      });

      emit(Shopsuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(Shoperrorstate());
    });
  }

  Categorymodel? categorymodel;
  void categorydata() {
    Diohleper.getdate(
            url: 'https://student.valuxapps.com/api/categories', token: token)
        .then((value) {
      categorymodel = Categorymodel.fromjson(value.data);
      emit(Categorysuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(Categoryerrorstate());
    });
  }

  Changefavouritmodel? changefavouritmodel;
  void changefaviourit(int? productid) {
    Diohleper.postdata(
      url: 'https://student.valuxapps.com/api/favorites',
      data: {'product_id': productid},
      token: token,
    ).then((value) {
      changefavouritmodel = Changefavouritmodel.fromjson(value.data);
      print(value.data);
      emit(Changefaviourtsuccessstate());
    }).catchError((error) {
      emit(Changefaviourterrorstate(error: error));
      print(error);
    });
  }
}
