import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/bloc/cubitlogin.dart';
import 'package:shopapp/bloc/registercubit.dart';
import 'package:shopapp/bloc/shoplayoutcubit.dart';
import 'package:shopapp/bloc/states/registerstates.dart';
import 'package:shopapp/bloc/states/shoplayoutstate.dart';
import 'package:shopapp/bloc/states/states.dart';
import 'package:shopapp/screen/login.dart';
import 'package:shopapp/screen/shoplayout.dart';
import 'package:shopapp/shared/constance.dart';
import 'package:shopapp/shared/network/component.dart';
import 'package:shopapp/shared/network/remote.dart';

class register extends StatelessWidget {
  register({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<registercubit, registerstates>(
        listener: (context, state) {
      if (state is Successregisterstate) {
        if (state.loginmodel!.status!) {
          print(state.loginmodel!.message);
          print(state.loginmodel!.data!.token);
          Catchelper.savedata(
                  key: 'token', value: state.loginmodel!.data!.token)
              .then((value) {
            token = state.loginmodel!.data!.token;
            navigateAndFinish(context: context, widget: Shoplayout1());
          });
        } else {
          print(state.loginmodel!.message);
          showtoast(text: state.loginmodel!.message!, state: toaststate.error);
        }
      }
    }, builder: (context, state) {
      var cubit = registercubit.get(context);
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'register',
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.headline4),
                    ),
                    Text(
                      'welcome to our system register !',
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
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
                      height: 12.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      onFieldSubmitted: (value) {},
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        label: Text('email'),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "the email must be fill";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phonecontroller,
                      onFieldSubmitted: (value) {},
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        label: Text('phone'),
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "the phone must be fill";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passcontroller,
                      onFieldSubmitted: (value) {},
                      onChanged: (value) {},
                      obscureText: cubit.ispass,
                      decoration: InputDecoration(
                        label: const Text('password'),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: MaterialButton(
                          onPressed: () {
                            cubit.changepassvisible();
                          },
                          child: Icon(cubit.icons),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "the password must be fill";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ConditionalBuilder(
                        condition: state is! Circleregisterstate,
                        builder: (context) => Container(
                              width: double.infinity,
                              height: 40.0,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    cubit.registeruser(
                                        name: namecontroller.text,
                                        email: emailcontroller.text,
                                        phone: phonecontroller.text,
                                        password: passcontroller.text);
                                  }
                                },
                                child: const Text(
                                  "register",
                                ),
                                color: Colors.blue,
                              ),
                            ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator())),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
