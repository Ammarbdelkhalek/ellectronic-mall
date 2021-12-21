import 'dart:js';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/shoplayoutcubit.dart';
import 'package:shopapp/bloc/states/shoplayoutstate.dart';
import 'package:shopapp/models/categorymodel.dart';
import 'package:shopapp/models/homemmodel.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shoplayoutcubit, Shoplayoutstates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Shoplayoutcubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
                condition:
                    cubit.homemodel != null && cubit.categorymodel != null,
                builder: (context) =>
                    bannerdata(cubit.homemodel, cubit.categorymodel, context),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator())),
          );
        });
  }

  Widget bannerdata(Homemodel? model, Categorymodel? categorymodel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        color: Colors.white54,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'category',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              color: Colors.white60,
              height: 140,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.separated(
                padding: const EdgeInsetsDirectional.only(start: 10, top: 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => categoriesAvatar(
                    categorymodel!.data!.data![index], context),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                itemCount: categorymodel!.data!.data!.length,
              ),
            ),
            const Text(
              'New Product ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                childAspectRatio: 1 / 1.65,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildgridview(model.data!.products[index], context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildgridview(Productmodel? model, context) {
    var cubit = Shoplayoutcubit.get(context);
    return Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(model!.image!),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  child: const Text(
                    'dicount',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                )
            ]),
            Text(
              model.name!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.old_price}',
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12.0,
                      ),
                    ),
                  const Spacer(),
                  MaterialButton(
                    minWidth: 20.0,
                    onPressed: () {
                      cubit.changefaviourit(model.id!);
                      print(model.id);
                    },
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                          cubit.favoruit[model.id]! ? Colors.blue : Colors.grey,
                      child: const Icon(
                        Icons.favorite_outline_rounded,
                        size: 19.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Widget categoriesAvatar(Getcategorydata? model, context) {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 36,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35,
              child: Image(
                image: NetworkImage(model!.image!),
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
