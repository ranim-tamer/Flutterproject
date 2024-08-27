import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../cart/presentation/view/cart_view.dart';
import '../../../../favourites/presentation/view/favourites_view.dart';
import '../../../../home/presentation/view/home_view.dart';
import '../../../../profile/presentation/view/profile_view.dart';

class LayoutProvider extends ChangeNotifier{
  List<Widget> screens = [
     const HomeView(),
    const FavouritesView(),
    const CartView(),
    const ProfileView(),
  ];
  int currentIndex = 0;

  changeCurrentIndex({
    required int index,
}){
    currentIndex = index ;
    notifyListeners();
  }
}