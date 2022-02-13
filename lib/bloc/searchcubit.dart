import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/states/searchstates.dart';
import 'package:shopapp/models/searchmodel.dart';
import 'package:shopapp/shared/constance.dart';
import 'package:shopapp/shared/network/local.dart';

class searchcubit extends Cubit<SearchStates> {
  searchcubit() : super(SearchInitialState());
  static searchcubit get(context) => BlocProvider.of(context);
  searchmodel? model;
  void searchdata(String text) {
    emit(SearchLoadingState());
    Diohleper.postdata(
        url: 'https://student.valuxapps.com/api/products/search ',
        token: token,
        data: {
          'text': text,
        }).then((value) {
      model = searchmodel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(SearchErrorState());
    });
  }
}
