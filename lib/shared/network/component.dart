import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/screen/onbording.dart';

Widget pageviewitems(Boardingmodel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.network('${model.image}'),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Text(
          '${model.title}',
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 14.0,
        ),
        Text(
          '${model.body}',
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
void navigateTo({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateAndFinish({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.amber,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
  Color color = Colors.white,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
void showtoast({
  required String text,
  required toaststate state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choosecolor(state),
        textColor: Colors.white,
        fontSize: 16.0);
enum toaststate { succes, error, warning }

Color choosecolor(toaststate state) {
  Color? color;
  switch (state) {
    case toaststate.succes:
      color = Colors.blue;
      break;
    case toaststate.error:
      color = Colors.blue;
      break;
    case toaststate.warning:
      color = Colors.blue;
      break;
  }
  return color;
}
