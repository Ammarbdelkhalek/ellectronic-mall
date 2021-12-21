import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/shoplayoutcubit.dart';
import 'package:shopapp/bloc/states/shoplayoutstate.dart';
import 'package:shopapp/screen/login.dart';
import 'package:shopapp/shared/network/component.dart';
import 'package:shopapp/shared/network/remote.dart';

class Shoplayout1 extends StatelessWidget {
  const Shoplayout1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shoplayoutcubit, Shoplayoutstates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Shoplayoutcubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('salla'),
              actions: [
                MaterialButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.search_rounded,
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Catchelper.removedata(key: 'token');
                    navigateAndFinish(context: context, widget: Loginscreen());
                  },
                  child: const Icon(Icons.logout_outlined),
                )
              ],
            ),
            body: cubit.layouts[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.navigation,
              currentIndex: cubit.currentindex,
              onTap: (index) {
                cubit.changenavbar(index);
              },
            ),
          );
        });
  }
}
