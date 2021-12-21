import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/states/states.dart';
import 'package:shopapp/models/loginmodel.dart';
import 'package:shopapp/shared/network/local.dart';

class Applogincubit extends Cubit<Apploginstates> {
  Applogincubit() : super(Initialstate());
  static Applogincubit get(context) => BlocProvider.of(context);

  Shoploginmodel? loginmodel;
  void loginuser({
    required String email,
    required String password,
  }) {
    emit(Circleloginstate());
    Diohleper.postdata(url: 'https://student.valuxapps.com/api/login', data: {
      "email": email,
      "password": password,
    }).then((value) {
      print(value.data);
      loginmodel = Shoploginmodel.fromjson(value.data);

      emit(Successloginstate(loginmodel: loginmodel));
    }).catchError((error) {
      print(error.toString());
      emit(Errorloginstate(error: error.toString()));
    });
  }

  bool ispass = true;
  IconData icons = Icons.visibility_off_outlined;
  void changepassvisible() {
    ispass = !ispass;
    icons = ispass ? Icons.visibility_off_outlined : Icons.visibility;
    emit(Changevisiblestates());
  }
}
