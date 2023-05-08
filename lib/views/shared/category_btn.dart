import 'package:flutter/material.dart';
import 'package:flutter_online_shop/views/shared/app_style.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({super.key, this.onPress, required this.buttonClr, required this.lable});
  final void Function()? onPress;
  final Color buttonClr;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.251,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonClr,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(9)),
        ),
        child: Center(child: Text(lable, style: appStyle(20, buttonClr, FontWeight.w600),)),
      ),
    );
  }
}
