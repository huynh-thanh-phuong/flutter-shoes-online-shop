import 'package:flutter/material.dart';
import 'package:flutter_online_shop/models/sneaker_model.dart';
import 'package:flutter_online_shop/views/shared/stagget_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshort) {
          if (snapshort.connectionState ==
              ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshort.hasError) {
            return Text("Error ${snapshort.error}");
          } else {
            final male = snapshort.data;
            return StaggeredGridView.countBuilder(
                padding: EdgeInsets.zero,
                itemCount: male!.length,
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 16.h,
                scrollDirection: Axis.vertical,
                staggeredTileBuilder: (index) =>
                    StaggeredTile.extent(
                        (index % 2 == 0) ? 1 : 1,
                        (index % 4 == 1 || index % 4 == 3)
                            ? 285.h
                            : 252.h,
                ),
                itemBuilder: (context, index) {
                  final shoes = snapshort.data![index];
                  return StaggerTile(
                    price: "\$${shoes.price}",
                    name: shoes.name,
                    imageUrl: shoes.imageUrl[1],
                  );
                });
          }
        });
  }
}