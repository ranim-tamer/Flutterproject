import 'package:flutter/material.dart';

import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/functions/navigation.dart';
import '../../../layout/presentation/view/layout_view.dart';
import '../../../on_boarding/presentation/view/on_boarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        navigateAndRemoveUntil(
         context: context,
          screen: CacheHelper.getData(key: 'token') != null ? const LayoutView() : const OnBoardingView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          height: screenSize.height * .35,
          width: screenSize.width * .35,
        ),
      ),
    );
  }
}
