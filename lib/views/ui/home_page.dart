import 'package:flutter/material.dart';
import 'package:flutter_online_shop/controllers/product_provider.dart';
import 'package:flutter_online_shop/views/shared/app_style.dart';
import 'package:flutter_online_shop/views/shared/home_widget.dart';
import 'package:flutter_online_shop/views/shared/resuable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getMale();
    productNotifier.getFemale();
    productNotifier.getKids();
    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
                height: 325.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/top_image.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 8.w,
                    bottom: 15.h,
                  ),
                  width: 375.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResuableText(
                        text:"Athletics shoes",
                        style: appStyleWithHt(
                            42, Colors.white, FontWeight.bold, 1.5),
                      ),
                      ResuableText(
                        text: "Collection",
                        style: appStyleWithHt(
                            42, Colors.white, FontWeight.bold, 1.2),
                      ),
                      TabBar(
                        padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelStyle: appStyle(
                          24,
                          Colors.white,
                          FontWeight.bold,
                        ),
                        unselectedLabelColor: Colors.grey.withOpacity(0.3),
                        tabs: const [
                          Tab(
                            text: "Men Shoes",
                          ),
                          Tab(
                            text: "Women Shoes",
                          ),
                          Tab(
                            text: "kids Shoes",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 203.h,
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 12.w),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      HomeWidget(male: productNotifier.male, tabIndex: 0,),
                      HomeWidget(male: productNotifier.female, tabIndex: 1,),
                      HomeWidget(male: productNotifier.kids,tabIndex: 2,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}




