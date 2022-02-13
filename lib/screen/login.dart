import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/bloc/cubitlogin.dart';
import 'package:shopapp/bloc/states/states.dart';
import 'package:shopapp/screen/register.dart';
import 'package:shopapp/screen/shoplayout.dart';
import 'package:shopapp/shared/constance.dart';
import 'package:shopapp/shared/network/component.dart';
import 'package:shopapp/shared/network/remote.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({Key? key}) : super(key: key);
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Applogincubit(),
      child: BlocConsumer<Applogincubit, Apploginstates>(
          listener: (context, state) {
        if (state is Successloginstate) {
          if (state.loginmodel!.status!) {
            print(state.loginmodel!.message);
            print(state.loginmodel!.data!.token);
            Catchelper.savedata(
                    key: 'token', value: state.loginmodel!.data!.token)
                .then((value) {
              token = state.loginmodel!.data!.token;
              navigateAndFinish(context: context, widget: const Shoplayout1());
            });
          } else {
            print(state.loginmodel!.message);
            showtoast(
                text: state.loginmodel!.message!, state: toaststate.error);
          }
        }
      }, builder: (context, state) {
        var cubit = Applogincubit.get(context);
        return Scaffold(
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(2500),
            )),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 2, 70),
                  child: Row(children: const [
                    Text(
                      'welcome ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 0, 5),
                        child: Icon(
                          Icons.supervised_user_circle_sharp,
                          color: Colors.blue,
                        )),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(33, 8, 0, 0),
                    //   child: IconButton(
                    //     onPressed: () {
                    //
                    //     },
                    //     icon: Icon(Icons.menu, color:mycolor1 ,)),
                    // )
                  ])),
            ),
          ),
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
                        'login',
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline4),
                      ),
                      Text(
                        'welcome to our system login !',
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
                            return 'Email Address must be filled ';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 9.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passcontroller,
                        onFieldSubmitted: (value) {},
                        obscureText: cubit.ispass,
                        onChanged: (value) {},
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
                          condition: state is! Circleloginstate,
                          builder: (context) => Container(
                                width: double.infinity,
                                height: 40.0,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      cubit.loginuser(
                                          email: emailcontroller.text,
                                          password: passcontroller.text);
                                    }
                                  },
                                  child: const Text(
                                    "login",
                                  ),
                                  color: Colors.blue,
                                ),
                              ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator())),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          const Text("Don\'t have an account?"),
                          const SizedBox(
                            width: 5.0,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateAndFinish(
                                  context: context, widget: register());
                            },
                            child: const Text('register'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
