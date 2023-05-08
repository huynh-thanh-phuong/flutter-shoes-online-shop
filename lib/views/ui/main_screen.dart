import 'package:flutter/material.dart';
import 'package:flutter_online_shop/controllers/main_screen_provider.dart';
import 'package:flutter_online_shop/views/shared/bottom_nav_bar.dart';
import 'package:flutter_online_shop/views/ui/cart_page.dart';
import 'package:flutter_online_shop/views/ui/favorites.dart';
import 'package:flutter_online_shop/views/ui/home_page.dart';
import 'package:flutter_online_shop/views/ui/profile_page.dart';
import 'package:flutter_online_shop/views/ui/search_page.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const Favorites(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: pageList[mainScreenNotifier.pageIndex],
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}


