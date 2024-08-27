import 'package:flutter/material.dart';
import 'package:untitled4/features/home/presentation/view/widgets/counter_widget.dart';
import 'package:untitled4/features/home/presentation/view/widgets/custom_rate_widget.dart';
import '../../../../core/app_styles/app_styles.dart';
import '../../../../core/http_services/http_services.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../data/models/product_model.dart';

//ignore: must_be_immutable
class ProductDetailsView extends StatelessWidget {
  late int productId;

  ProductDetailsView({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<ProductModel>(
        future: getProductDetails(id: productId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomBackButton(),
                      Image.network(
                        snapshot.data!.image,
                        height: screenSize.height * .4,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: screenSize.height * .05,
                      ),
                      Text(
                        snapshot.data!.title,
                        style: AppStyles.style20,
                      ),
                      SizedBox(
                        height: screenSize.height * .01,
                      ),
                      Text(
                        snapshot.data!.category,
                        style: AppStyles.style16Grey,
                      ),
                      SizedBox(
                        height: screenSize.height * .02,
                      ),
                      const CustomRateWidget(),
                      SizedBox(
                        height: screenSize.height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CounterWidget(),
                          Text(
                            '${snapshot.data!.price} \$',
                            style: AppStyles.style20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * .02,
                      ),
                      const Text(
                        'Description',
                        style: AppStyles.style18Black,
                      ),
                      SizedBox(
                        height: screenSize.height * .01,
                      ),
                      Text(
                        snapshot.data!.description,
                        style: AppStyles.style18Grey,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return const CustomCircularProgressIndicator();
        },
      ),
    );
  }
}

Future<ProductModel> getProductDetails({
  required int id,
}) async {
  var data = await HttpServices.getData(path: 'products/$id');
  ProductModel product = ProductModel.fromJson(data);
  return product;
}
