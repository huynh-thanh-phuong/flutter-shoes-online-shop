import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/controllers/favorites_provider.dart';
import 'package:flutter_online_shop/views/shared/app_style.dart';
import 'package:flutter_online_shop/views/ui/main_screen.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    favoritesNotifier.getAllData();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: Text(
                "My Favorites",
                style: appStyle(40, Colors.black, FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                  itemCount: favoritesNotifier.fav.length,
                  padding: const EdgeInsets.only(top: 100),
                  itemBuilder: (context, int index) {
                    final data = favoritesNotifier.fav[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade500,
                                spreadRadius: 5,
                                blurRadius: 0.3,
                                offset: const Offset(0, 1),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: CachedNetworkImage(
                                      imageUrl: data['imageUrl'],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['name'],
                                          style: appStyle(16, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          data['category'],
                                          style: appStyle(
                                              14, Colors.grey, FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "\$${data['price']}",
                                              style: appStyle(16, Colors.black,
                                                  FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: (){
                                    favoritesNotifier.deleteFav(data['key']);
                                    favoritesNotifier.ids.removeWhere((element) => element == data['id']);
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                                  },
                                  child: const Icon(Ionicons.md_heart_dislike),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
