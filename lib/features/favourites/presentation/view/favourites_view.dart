import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/features/favourites/presentation/view/widgets/favourites_item.dart';
import '../../../../core/app_styles/app_styles.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../manager/favourites_provider/favourite_provider.dart';


class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavouritesProvider>(
        builder: (context,favProvider,child){
          if(!favProvider.isFavProductsLoading){
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Favourites',
                      style: AppStyles.style20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return FavouriteItem(
                          product: favProvider.favProducts[index],
                        );
                      },
                      separatorBuilder: (context,index){
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: favProvider.favProducts.length,
                    ),
                  ],
                ),
              ),
            );
          }
          else{
            return const CustomCircularProgressIndicator();
          }
        },
      ),
    );
  }
}

