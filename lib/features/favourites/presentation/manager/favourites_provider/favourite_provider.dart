import 'package:flutter/foundation.dart';

import '../../../../../core/app_sqflite/sql.dart';
import '../../../../home/data/models/product_model.dart';

class FavouritesProvider extends ChangeNotifier {

  bool isFavProductsLoading = true ;
  List<int> favIds = [];
  List<ProductModel> favProducts = [];

  getFavIds()async{
    favProducts = favProducts = await Sql.getAllProducts();
    for(var product in favProducts){
      favIds.add(product.id);
    }
    isFavProductsLoading = false;
    notifyListeners();
  }


  addProductToFavorites({
    required ProductModel product,
}) async {
    // bool isAlreadyInFavorites = await isProductInFavorites(productId);

    // if (!isAlreadyInFavorites) {
    favIds.add(product.id);
    favProducts.add(product);
      await Sql.insertProducts(
        ProductModel(
          title: product.title,
          image: product.image,
          price: product.price,
          description: product.description,
          id: product.id,
          category: product.category,
        ),
      );
      // favoriteProductIds = Sql.getAllProducts();
      notifyListeners();
    // }
  }

  removeProductFromFavorites(ProductModel product) async {
    // bool isAlreadyInFavorites = await isProductInFavorites(productId);

    // if (isAlreadyInFavorites) {
    favIds.remove(product.id);
    favProducts.remove(product);
      await Sql.instance.deleteProducts(product.id);
      // favoriteProductIds = Sql.getAllProducts();
      notifyListeners();
    // }
  }
}
