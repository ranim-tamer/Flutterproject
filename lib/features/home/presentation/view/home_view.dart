import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/features/home/presentation/view/widgets/category_item.dart';
import 'package:untitled4/features/home/presentation/view/widgets/product_item.dart';
import 'package:untitled4/features/home/presentation/view/widgets/search_widget.dart';
import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/app_styles/app_styles.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../profile/presentation/manager/profile_provider/profile_provider.dart';
import '../manager/home_provider/home_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Welcome',
                            style: AppStyles.style20,
                          ),
                          Consumer<ProfileProvider>(
                            builder: (context, profileProvider, child) {
                              if (profileProvider.isUserDataLoading ==
                                  false) {
                                return Text(
                                  ' ${profileProvider.user.userName}',
                                  style: AppStyles.style18Black,
                                );
                              }
                              return const CustomCircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                      Container(
                        height: screenSize.height * .1,
                        width: screenSize.width * .15,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                AppAssets.userImage,
                              ),
                            ),
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * .03,
                  ),
                  const SearchWidget(),
                  SizedBox(
                    height: screenSize.height * .03,
                  ),
                  Consumer<HomeProvider>(
                    builder: (context,homeProvider,child){
                      if(homeProvider.isProductsLoading == true){
                        return const CustomCircularProgressIndicator();
                      }
                      return SizedBox(
                        height: 40,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                               SizedBox(
                                  height : 40 ,
                                  child: GestureDetector(
                                    onTap: (){
                                      homeProvider.colorAllProductCategory();
                                      homeProvider.getAllProducts();
                                    },
                                    child: CategoryItem(
                                      categoryTitle: 'All Products',
                                      isSelected: homeProvider.isAllProductsShown,
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      homeProvider.changeIndex(index);
                                      homeProvider.getProductsSpecificInCategory(category: homeProvider.categories[index]);
                                    },
                                    child: CategoryItem(
                                      isSelected: homeProvider.isAllProductsShown ? false : homeProvider.currentIndex == index ? true : false ,
                                        categoryTitle:
                                        homeProvider
                                            .categories[index]),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                                itemCount:
                                homeProvider
                                    .categories
                                    .length,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * .03,
                  ),
                  Selector<HomeProvider, bool>(
                    builder: (BuildContext context, bool isProductsLoading,
                        Widget? child) {
                      if (isProductsLoading == true) {
                        return const CustomCircularProgressIndicator();
                      }
                      return GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: 1 / 1.6,
                        crossAxisSpacing: screenSize.width * .03,
                        mainAxisSpacing: screenSize.height * .015,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        children: Provider.of<HomeProvider>(context)
                            .products
                            .map((product) => ProductItem(
                                  product: product,
                                ))
                            .toList(),
                      );
                    },
                    selector: (BuildContext context, homeProvider) =>
                        homeProvider.isProductsLoading,
                  ),
                ],
              ),
            )));
  }
}
