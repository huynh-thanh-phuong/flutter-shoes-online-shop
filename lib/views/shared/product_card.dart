import 'package:flutter/material.dart';
import 'package:flutter_online_shop/controllers/favorites_provider.dart';
import 'package:flutter_online_shop/views/shared/app_style.dart';
import 'package:flutter_online_shop/views/shared/resuable_text.dart';
import 'package:flutter_online_shop/views/ui/favorites.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavorites();
    bool isSelect = true;
    return Padding(
      padding: EdgeInsets.only(left:8.w, right: 20.w,),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.h)),
        child: Container(
          height: 325.h,
          width: 225.w,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 0.6,
              offset: Offset(0, 1),
            ),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 186.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    top: 10.h,
                    child: Consumer<FavoritesNotifier>(
                        builder: (context, favoritesNotifier, child) {
                      return GestureDetector(
                        onTap: () async {
                          if (favoritesNotifier.ids.contains(widget.id)) {                    
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const Favorites())));
                          } else {
                            favoritesNotifier.createFav({
                              "id": widget.id,
                              "name": widget.name,
                              "category": widget.category,
                              "price": widget.price,
                              "imageUrl": widget.image,
                            });
                          }
                          setState(() {});
                        },
                      child: favoritesNotifier.ids.contains(widget.id)
                          ? Icon(AntDesign.heart, color: Colors.red.shade400)
                          : const Icon(AntDesign.hearto),
                    );
                    }),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResuableText(
                      text:widget.name,
                      style: appStyleWithHt(
                        24,
                        Colors.black,
                        FontWeight.bold,
                        1.1,
                      ),
                    ),
                    ResuableText(
                      text:widget.category,
                      style: appStyleWithHt(
                        20,
                        Colors. grey,
                        FontWeight.bold,
                        1.5,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w,right: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ResuableText(text:widget.price,style: appStyle(20, Colors.black, FontWeight.w600,),),
                    Row(
                      children: [
                        ResuableText(text:"Colors",style: appStyle(18, Colors.grey, FontWeight.w500),),
                        SizedBox(
                          width: 5.w,
                        ),
                        ChoiceChip(
                          label: const Text(""),
                          selected: isSelect,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
