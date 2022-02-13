import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/shoplayoutcubit.dart';
import 'package:shopapp/bloc/states/shoplayoutstate.dart';
import 'package:shopapp/models/getfaviouritedatamodel.dart';

class faviourit extends StatelessWidget {
  const faviourit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shoplayoutcubit, Shoplayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Shoplayoutcubit.get(context);
        return Scaffold(
            body: Conditional.single(
          context: context,
          conditionBuilder: (context) => state is! Favoriteloadingstate,
          widgetBuilder: (context) =>
              cubit.getfavoritemodel!.data!.data!.length == 0
                  ? const Center(
                      child: Text(
                        'You don\'t have item',
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) => buildfaviouritelist(
                          cubit.getfavoritemodel!.data!.data![index].product!,
                          context),
                      separatorBuilder: (context, index) => Container(
                            height: 5.0,
                            width: double.infinity,
                          ),
                      itemCount: cubit.getfavoritemodel!.data!.data!.length),
          fallbackBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
        )

            /*Conditional.single(
            condition: state is! Favoriteloadingstate,
            builder: (context) => cubit.getfavoritemodel!.data!.data!.isEmpty
                ? const Center(
                    child: Text(
                      'You don\'t have item',
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) => buildfaviouritelist(
                        cubit.getfavoritemodel!.data!.data![index].product!,
                        context),
                    separatorBuilder: (context, index) => Container(
                          height: 5.0,
                          width: double.infinity,
                        ),
                    itemCount: cubit.getfavoritemodel!.data!.data!.length),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
          */
            );
      },
    );
  }

  Widget buildfaviouritelist(faviouriteProduct model, context) {
    var cubit = Shoplayoutcubit.get(context);
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage(model.image),
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
            model.name,
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
                  '${model.price!.toString()}',
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
                    '${model.oldPrice.toString()}',
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
                    cubit.changefaviourit(model.id);
                  },
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: cubit.favorites[model.id] == true
                        ? Colors.deepOrange
                        : Colors.grey[200],
                    child: Icon(
                      cubit.favorites[model.id] == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 19.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
