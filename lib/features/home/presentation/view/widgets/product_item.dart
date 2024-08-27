import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/app_styles/app_styles.dart';
import '../../../../../core/functions/navigation.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../cart/presentation/manager/cart_provider/cart_provider.dart';
import '../../../../favourites/presentation/manager/favourites_provider/favourite_provider.dart';
import '../../../data/models/product_model.dart';
import '../product_details_view.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    // final favouriteProvider = Provider.of<FavouriteProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        navigate(
          context: context,
          screen: ProductDetailsView(
            productId: product.id,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          child: Column(
            children: [
              Image(
                height: screenSize.height * .15,
                image: NetworkImage(
                  product.image,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.style15Black,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<FavouritesProvider>(
                    builder: (context,favProvider,child){
                      return CustomIconButton(
                        onPressed: () async{
                          if(favProvider.favIds.contains(product.id)){
                            favProvider.removeProductFromFavorites(product);
                          }
                          else{
                            favProvider.addProductToFavorites(product: product);
                          }
                        },
                        icon:Icons.favorite,
                        color: favProvider.favIds.contains(product.id)? Colors.red : Colors.grey,
                        // favouriteProvider.iconColor,
                      );
                    },
                  ),
                  Consumer<CartProvider>(
                    builder: (context,cartProvider,child){
                      return  CustomIconButton(
                        onPressed: () {
                          cartProvider.addOrRemoveCart(productId: product.id);
                        },
                        icon: Icons.shopping_cart_outlined,
                        color: cartProvider.cartIds.contains(product.id)? Colors.blue : Colors.grey,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
