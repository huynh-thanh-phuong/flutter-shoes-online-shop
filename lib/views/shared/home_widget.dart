import 'package:flutter/material.dart';
import 'package:flutter_online_shop/controllers/product_provider.dart';
import 'package:flutter_online_shop/models/sneaker_model.dart';
import 'package:flutter_online_shop/views/shared/app_style.dart';
import 'package:flutter_online_shop/views/shared/new_shoes.dart';
import 'package:flutter_online_shop/views/shared/product_card.dart';
import 'package:flutter_online_shop/views/shared/resuable_text.dart';
import 'package:flutter_online_shop/views/ui/product_by_cat.dart';
import 'package:flutter_online_shop/views/ui/product_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male, required this.tabIndex,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final int tabIndex;
  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
          height: 325.h,
          child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshort) {
                if (snapshort.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshort.hasError) {
                  return Text("Error ${snapshort.error}");
                } else {
                  final male = snapshort.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoes = snapshort.data![index];
                        return GestureDetector(
                          onTap: (){
                            productNotifier.shoesSizes = shoes.sizes;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                  id: shoes.id,
                                  category: shoes.category,
                                ),
                              ),
                            );
                          },
                          child: ProductCard(
                            price: "\$${shoes.price}",
                            category: shoes.category,
                            id: shoes.id,
                            name: shoes.name,
                            image: shoes.imageUrl[0],
                          ),
                        );
                      });
                }
              }),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 20.h, 12.w, 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ResuableText(
                    text: "Latest Shoes",
                    style: appStyle(
                      24,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 80.w,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductByCat(
                                    tabIndex: tabIndex,
                                  )));                     
                    },
                    child: Row(
                      children: [
                        ResuableText(
                          text:"Show All",
                          style: appStyle(
                            22,
                            Colors.black,
                            FontWeight.w500,
                          ),
                        ),
                        Icon(
                          AntDesign.caretright,
                          size: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 99.h,
          child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshort) {
                if (snapshort.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshort.hasError) {
                  return Text("Error ${snapshort.error}");
                } else {
                  final male = snapshort.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoes = snapshort.data![index];
                        return Padding(
                          padding: EdgeInsets.all(8.0.h),
                          child: NewShoes(imageUrl: shoes.imageUrl[1]),
                        );
                      });
                }
              }),
        )
      ],
    );
  }
}