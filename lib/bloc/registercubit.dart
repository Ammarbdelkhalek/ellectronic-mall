import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/states/registerstates.dart';
import 'package:shopapp/models/loginmodel.dart';
import 'package:shopapp/shared/network/local.dart';

class registercubit extends Cubit<registerstates> {
  registercubit() : super(initialregisterstate());
  static registercubit get(context) => BlocProvider.of(context);
  Shoploginmodel? registermodel;
  void registeruser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(Circleregisterstate());
    Diohleper.postdata(
        url: 'https://student.valuxapps.com/api/register',
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
        }).then((value) {
      print(value.data);
      registermodel = Shoploginmodel.fromjson(value.data);

      emit(Successregisterstate(loginmodel: registermodel));
    }).catchError((error) {
      print(error.toString());
      emit(Errorregisterstate(error: error.toString()));
    });
  }

  bool ispass = true;
  IconData icons = Icons.visibility_off_outlined;
  void changepassvisible() {
    ispass = !ispass;
    icons = ispass ? Icons.visibility_off_outlined : Icons.visibility;
    emit(changepassstate());
  }
}
