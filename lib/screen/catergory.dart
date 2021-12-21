import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/shoplayoutcubit.dart';
import 'package:shopapp/bloc/states/shoplayoutstate.dart';
import 'package:shopapp/models/categorymodel.dart';

class category extends StatelessWidget {
  const category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shoplayoutcubit, Shoplayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Shoplayoutcubit.get(context);
        return Scaffold(
          body: Container(
            color: Colors.white60,
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.only(start: 10, top: 10),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => categoriesAvatar(
                  cubit.categorymodel!.data!.data![index], context),
              separatorBuilder: (context, index) => const SizedBox(
                height: 12.0,
              ),
              itemCount: cubit.categorymodel!.data!.data!.length,
            ),
          ),
        );
      },
    );
  }

  Widget categoriesAvatar(Getcategorydata? model, context) {
    return Column(
      children: [
        Row(children: [
          Image(
            image: NetworkImage(model!.image!),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.name!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          MaterialButton(
            onPressed: () {},
            child: const Icon(Icons.keyboard_arrow_right_sharp),
          )
        ])
      ],
    );
  }
}
