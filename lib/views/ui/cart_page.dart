import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/controllers/cart_provider.dart';
import 'package:flutter_online_shop/views/shared/app_style.dart';
import 'package:flutter_online_shop/views/shared/checkout_btn.dart';
import 'package:flutter_online_shop/views/ui/main_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cartNotifier = Provider.of<CartNotifier>(context);
    cartNotifier.getCart();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "My cart",
                  style: appStyle(34, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: cartNotifier.cart.isEmpty
                      ? const Text("Gio trong")
                      : ListView.builder(
                          itemCount: cartNotifier.cart.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final data = cartNotifier.cart[index];
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        flex: 1,
                                        onPressed: (context) {},
                                        backgroundColor:
                                            const Color(0xFF000000),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.11,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade500,
                                            spreadRadius: 5,
                                            blurRadius: 0.3,
                                            offset: const Offset(0, 1),
                                          ),
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: CachedNetworkImage(
                                                    imageUrl: data['imageUrl'],
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: -2,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      cartNotifier.deleteCart(data['key']);
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                   MainScreen()));
                                                    },
                                                    child: Container(
                                                      width: 40,
                                                      height: 30,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        12)),
                                                      ),
                                                      child: const Icon(
                                                        AntDesign.delete,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12, left: 20),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data['name'],
                                                    style: appStyle(
                                                        16,
                                                        Colors.black,
                                                        FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    data['category'],
                                                    style: appStyle(
                                                        14,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "\$${data['price']}",
                                                        style: appStyle(
                                                            16,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        "Size :",
                                                        style: appStyle(
                                                            14,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        data['sizes'],
                                                        style: appStyle(
                                                            14,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16)),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: const Icon(
                                                        AntDesign.plussquare,
                                                        size: 20,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      data['qty'].toString(),
                                                      style: appStyle(
                                                          16,
                                                          Colors.black,
                                                          FontWeight.w600),
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: const Icon(
                                                        AntDesign.minussquare,
                                                        size: 20,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CheckOutButton(
                lable: "Proceed to CheckOut",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
