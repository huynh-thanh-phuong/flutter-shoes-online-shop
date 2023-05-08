import 'package:flutter/material.dart';
import 'package:flutter_online_shop/controllers/cart_provider.dart';
import 'package:flutter_online_shop/controllers/favorites_provider.dart';
import 'package:flutter_online_shop/controllers/main_screen_provider.dart';
import 'package:flutter_online_shop/controllers/product_provider.dart';
import 'package:flutter_online_shop/views/ui/main_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (context) => ProductNotifier()),
        ChangeNotifierProvider(create: (context) => CartNotifier()),
        ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      );
    });
  }
}
