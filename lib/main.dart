import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_sqflite/sql.dart';
import 'core/cache_helper/cache_helper.dart';
import 'features/auth/presentation/manager/auth_provider/auth_provider.dart';
import 'features/cart/presentation/manager/cart_provider/cart_provider.dart';
import 'features/favourites/presentation/manager/favourites_provider/favourite_provider.dart';
import 'features/home/presentation/manager/home_provider/home_provider.dart';
import 'features/layout/presentation/manager/layout_provider/layout_provider.dart';
import 'features/profile/presentation/manager/profile_provider/profile_provider.dart';
import 'features/splash/presentation/view/splash_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Sql.instance.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider()
            ..getAllCategories()
            ..getAllProducts(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LayoutProvider(),
        ),
        ChangeNotifierProvider<FavouritesProvider>(
          create: (context) => FavouritesProvider()..getFavIds(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider()..getAllCart(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider()..getUserData(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            canvasColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashView()),
    );
  }
}
