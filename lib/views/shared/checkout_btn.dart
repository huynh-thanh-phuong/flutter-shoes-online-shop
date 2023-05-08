
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/views/shared/app_style.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    super.key, this.onTap, required this.lable,
  });
  final void Function()? onTap;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: Text(lable, style: appStyle(20, Colors.white, FontWeight.bold),),
          ),
        ),
      ),
    );
  }
}