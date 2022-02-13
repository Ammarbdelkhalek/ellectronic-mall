import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/states/shoplayoutstate.dart';
import 'package:shopapp/models/categorymodel.dart';
import 'package:shopapp/models/faviouritemodel.dart';
import 'package:shopapp/models/getfaviouritedatamodel.dart';
import 'package:shopapp/models/getfaviouritedatamodel.dart';
import 'package:shopapp/models/homemmodel.dart';
import 'package:shopapp/models/loginmodel.dart';
import 'package:shopapp/models/profilemodel.dart';
import 'package:shopapp/screen/catergory.dart';
import 'package:shopapp/screen/favourit.dart';
import 'package:shopapp/screen/home.dart';
import 'package:shopapp/screen/setting.dart';
import 'package:shopapp/shared/constance.dart';
import 'package:shopapp/shared/network/local.dart';
import 'package:shopapp/shared/network/remote.dart';

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

  List<Widget> layouts = [
    const Home(),
    const category(),
    const faviourit(),
    setting()
  ];

  void changenavbar(index) {
    currentindex = index;
    emit(Changenavstate());
  }

  Map<int, bool> favorites = {};

  Homemodel? homemodel;

  void homedata() {
    emit(Shoploadingstate());
    Diohleper.getdate(
            url: 'https://student.valuxapps.com/api/home', token: token)
        .then((value) {
      homemodel = Homemodel.fromjson(value.data);
      print(value);
      printFullText(homemodel!.data!.banners[0].image!);
      print(homemodel!.status);
      homemodel!.data!.products.forEach((element) {
        (favorites.addAll({element.id!: element.in_favorites!}));
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

  String? token = Catchelper.getdata(key: 'token');

  Changefavouritmodel? changefavouritmodel;

  void changefaviourit(int? productid) {
    favorites[productid!] = !favorites[productid]!;
    emit(changefaviourtestats());
    Diohleper.postdata(
      url: 'https://student.valuxapps.com/api/favorites',
      data: {
        'product_id': productid,
      },
      token: token,
    ).then((value) {
      changefavouritmodel = Changefavouritmodel.fromjson(value.data);
      if (!changefavouritmodel!.status) {
        favorites[productid] = !favorites[productid]!;
      } else {
        getfavoritdata();
      }

      emit(Changefaviourtsuccessstate(model: changefavouritmodel));
    }).catchError((error) {
      favorites[productid] = !favorites[productid]!;
      emit(Changefaviourterrorstate(error: error));
      print(error.toString());
    });
  }

  FavoritesModel? getfavoritemodel;

  void getfavoritdata() {
    emit(Favoriteloadingstate());
    Diohleper.getdate(
            url: 'https://student.valuxapps.com/api/favorites', token: token)
        .then((value) {
      getfavoritemodel = FavoritesModel.fromJson(value.data);
      print(value.toString());
      emit(Favoritesuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(Favoriteerrorstate());
    });
  }

  profilemodel? getprofile;

  void getprofiledata() {
    emit(profileerrorstate());
    Diohleper.getdate(
            url: "https://student.valuxapps.com/api/profile", token: token)
        .then((value) {
      getprofile = profilemodel.fromJson(value.data);
      printFullText(value.toString());
      emit(profilesuccessstate(getprofile: getprofile));
    }).catchError((error) {
      print(error.toString());
      emit(profileerrorstate());
    });
  }

  Shoploginmodel? updateusermodel;
  void updateuser({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(Circleupdatestate());
    Diohleper.putdata(
        url: 'https://student.valuxapps.com/api/update-profile',
        data: {
          "name": name,
          "email": email,
          "phone": phone,
        }).then((value) {
      print(value.data);
      updateusermodel = Shoploginmodel.fromjson(value.data);

      emit(Successupdatestate(updateusermodel: updateusermodel));
    }).catchError((error) {
      print(error.toString());
      emit(Errorupdatestate(error: error.toString()));
    });
  }
}
