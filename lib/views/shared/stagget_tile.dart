import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/views/shared/app_style.dart';
import 'package:flutter_online_shop/views/shared/resuable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({super.key, required this.imageUrl, required this.name, required this.price});
  final String imageUrl;
  final String name;
  final String price;

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16.h)),
      ),
      child: Padding(
        padding:  EdgeInsets.all(8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.fill,
            ),
            Container(
              padding:  EdgeInsets.only(top: 12.h,),
              height: 75.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResuableText(
                    text: widget.name,
                    style: appStyleWithHt(20, Colors.black, FontWeight.w700, 1),
                  ),
                  ResuableText(
                    text: widget.price,
                    style: appStyleWithHt(18, Colors.black, FontWeight.w500,1),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}