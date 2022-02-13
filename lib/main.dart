import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/registercubit.dart';
import 'package:shopapp/bloc/shoplayoutcubit.dart';
import 'package:shopapp/screen/login.dart';
import 'package:shopapp/screen/onbording.dart';
import 'package:shopapp/screen/shoplayout.dart';
import 'package:shopapp/shared/network/local.dart';
import 'package:shopapp/shared/network/remote.dart';
import 'package:shopapp/thems/darkandlight.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'bloc/cubitlogin.dart';
import 'bloc/observationcubit.dart';
import 'bloc/searchcubit.dart';
import 'bloc/states/states.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Catchelper.init();
  Diohleper.init();
  bool? onboarding = Catchelper.getdata(key: 'onboarding');
  bool? isdark = Catchelper.getdata(key: 'isdark');
  String? token = Catchelper.getdata(key: 'token');
  Widget widget;
  if (onboarding != null) {
    if (token != null) {
      widget = const Shoplayout1();
    } else {
      widget = Loginscreen();
    }
  } else {
    widget = Onboarding();
  }
  runApp(Shopapp(
    isdark: isdark,
    startwidget: widget,
  ));
}

class Shopapp extends StatelessWidget {
  final Widget? startwidget;
  final bool? isdark;
  final String? token;

  Shopapp({this.startwidget, this.isdark, this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => Applogincubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => searchcubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => registercubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => Shoplayoutcubit()
            ..homedata()
            ..categorydata()
            ..getfavoritdata()
            ..getprofiledata(),
        ),
      ],
      child: BlocConsumer<Applogincubit, Apploginstates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              home: SplashScreenView(
                navigateRoute: startwidget,
                duration: 3000,
                imageSize: 130,
                pageRouteTransition: PageRouteTransition.SlideTransition,
                backgroundColor: Colors.blueAccent,
              ),
              theme: lightMode(),
            );
          }),
    );
  }
}
