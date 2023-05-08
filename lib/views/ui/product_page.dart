import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/controllers/favorites_provider.dart';
import 'package:flutter_online_shop/controllers/product_provider.dart';
import 'package:flutter_online_shop/models/sneaker_model.dart';
import 'package:flutter_online_shop/services/helper.dart';
import 'package:flutter_online_shop/views/shared/app_style.dart';
import 'package:flutter_online_shop/views/shared/checkout_btn.dart';
import 'package:flutter_online_shop/views/ui/favorites.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  late Future<Sneakers> _sneaker;
  final _cartBox = Hive.box('cart_box');

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getMaleSneakerById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getFemaleSneakerById(widget.id);
    } else {
      _sneaker = Helper().getKidSneakerById(widget.id);
    }
  }
  Future<void> _createCart(Map<String,dynamic> newCart)async{
    await _cartBox.add(newCart);
  }
  @override
  void initState() {
    super.initState();
    getShoes();
  }
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getAllData(); 
    return Scaffold(
      body: FutureBuilder<Sneakers>(
          future: _sneaker,
          builder: (context, snapshort) {
            if (snapshort.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshort.hasError) {
              return Text("Error ${snapshort.error}");
            } else {
              final sneaker = snapshort.data;
              return Consumer<ProductNotifier>(
                builder: (context, productNotifier, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        leadingWidth: 0,
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  productNotifier.shoesSizes.clear();
                                },
                                child: const Icon(
                                  AntDesign.close,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(Ionicons.ellipsis_horizontal,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        pinned: true,
                        snap: false,
                        floating: true,
                        backgroundColor: Colors.transparent,
                        expandedHeight: MediaQuery.of(context).size.height,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              SizedBox(
                                height:401.h,
                                width: 375.w,
                                child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sneaker!.imageUrl.length,
                                  controller: pageController,
                                  onPageChanged: (page) {
                                    productNotifier.activePage = page;
                                  },
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: 316.h,
                                          width: 375.w,
                                          color: Colors.grey.shade300,
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          top: 98.h,
                                          right: 20.w,
                                          child: Consumer<FavoritesNotifier>(builder: (context,
                                              favoritesNotifier, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (favoritesNotifier.ids.contains(widget.id)) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Favorites()));
                                                } else {
                                                  favoritesNotifier.createFav({
                                                    "id": sneaker.id,
                                                    "name": sneaker.name,
                                                    "category":
                                                        sneaker.category,
                                                    "price": sneaker.price,
                                                    "imageUrl":
                                                        sneaker.imageUrl[0],
                                                  });
                                                }
                                                setState(() {});
                                              },
                                              child: favoritesNotifier.ids.contains(sneaker.id)
                                                  ? Icon(
                                                      AntDesign.heart,
                                                      color: Colors.red.shade400,
                                                    )
                                                  : const Icon(
                                                      AntDesign.hearto),
                                            );
                                          }),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List<Widget>.generate(
                                                sneaker.imageUrl.length,
                                                (index) => Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4),
                                                      child: CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor:
                                                            productNotifier
                                                                        .activePage !=
                                                                    index
                                                                ? Colors.grey
                                                                : Colors.black,
                                                      ),
                                                    )),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.645,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sneaker.name,
                                            style: appStyle(30, Colors.black,
                                                FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                sneaker.category,
                                                style: appStyle(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              RatingBar.builder(
                                                  initialRating: 4,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 22,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(horizontal: 1),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                        Icons.star,
                                                        size: 18,
                                                        color: Colors.black,
                                                      ),
                                                  onRatingUpdate: (rating) {})
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${sneaker.price}",
                                                style: appStyle(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Colors",
                                                    style: appStyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Select sizes",
                                                    style: appStyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 40,
                                                  ),
                                                  Text(
                                                    "View size guide ",
                                                    style: appStyle(
                                                        20,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                child: ListView.builder(
                                                  itemCount: productNotifier
                                                      .shoesSizes.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final sizesData = productNotifier.shoesSizes[index];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                          child: ChoiceChip(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              60),
                                                                  side: const BorderSide(
                                                                      color: Colors
                                                                          .black,
                                                                      width: 1,
                                                                      style: BorderStyle
                                                                          .solid)),
                                                              disabledColor:
                                                                  Colors.white,
                                                              label: Text(
                                                                sizesData['size'],
                                                                style: appStyle(
                                                                    18,
                                                                    sizesData['isSelected']
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    FontWeight
                                                                        .w500),
                                                              ),
                                                              selectedColor:
                                                                  Colors.black,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8),
                                                              selected: sizesData[
                                                                  'isSelected'],
                                                              onSelected:
                                                                  (newState) {
                                                                if (productNotifier
                                                                    .sizes
                                                                    .contains(sizesData[
                                                                        'size'])) {
                                                                  productNotifier
                                                                      .sizes
                                                                      .remove(sizesData[
                                                                          'size']);
                                                                } else {
                                                                  productNotifier
                                                                      .sizes
                                                                      .add(sizesData[
                                                                          'size']);
                                                                }
                                                                productNotifier
                                                                    .toggleCheck(
                                                                        index);
                                                              },
                                                            ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          //duong ke ngang
                                          const Divider(
                                            indent: 10,
                                            endIndent: 10,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(height: 10,),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            child: Text(
                                              sneaker.title, style: appStyle(20, Colors.black, FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          Text(
                                            sneaker.description,
                                            textAlign: TextAlign.justify,
                                            maxLines: 4,
                                            style: appStyle(14, Colors.black, FontWeight.normal),
                                          ),
                                          const SizedBox(height: 10,),
                                           Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: CheckOutButton(
                                                onTap:()async{
                                                  _createCart({
                                                    "id": sneaker.id,
                                                    "name": sneaker.name,
                                                    "category": sneaker.category,
                                                    "sizes": productNotifier.sizes[0],
                                                    "imageUrl":sneaker.imageUrl[0],
                                                    "price": sneaker.price,
                                                    "qty": 1,
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                lable: "Add to Cart",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}

