import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/shoplayoutcubit.dart';
import 'package:shopapp/bloc/states/shoplayoutstate.dart';
import 'package:shopapp/shared/network/component.dart';
import 'package:shopapp/shared/network/remote.dart';

import 'login.dart';

class setting extends StatelessWidget {
  setting({Key? key}) : super(key: key);
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shoplayoutcubit, Shoplayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = Shoplayoutcubit.get(context).getprofile;
        namecontroller.text = model!.data!.name!;
        emailcontroller.text = model.data!.email!;
        phonecontroller.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: (model != null),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              key: formKey,
              children: [
                if (state is Circleupdatestate) const LinearProgressIndicator(),
                Text(
                  'welcome  ${model.data!.name!}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${Shoplayoutcubit.get(context).updateusermodel!.data!.email}',
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: namecontroller,
                  onFieldSubmitted: (value) {},
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    label: Text('name'),
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'name must be filled ';
                    }
                  },
                ),
                const SizedBox(
                  height: 9.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailcontroller,
                  onFieldSubmitted: (value) {},
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    label: Text('email'),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'email must be filled ';
                    }
                  },
                ),
                const SizedBox(
                  height: 9.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: phonecontroller,
                  onFieldSubmitted: (value) {},
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    label: Text('phone'),
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'name must be filled ';
                    }
                  },
                ),
                const SizedBox(
                  height: 9.0,
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.brown),
                  child: MaterialButton(
                    onPressed: () {
                      Catchelper.removedata(key: 'token');
                      navigateAndFinish(
                          context: context, widget: Loginscreen());
                    },
                    animationDuration:
                        const Duration(minutes: 1, microseconds: 2),
                    child: const Text(
                      "log out ",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Shoplayoutcubit.get(context).updateuser(
                          name: namecontroller.text,
                          email: emailcontroller.text,
                          phone: phonecontroller.text,
                        );
                      }
                    },
                    animationDuration:
                        const Duration(minutes: 1, microseconds: 2),
                    child: const Text(
                      "update data ",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
