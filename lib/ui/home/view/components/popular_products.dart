import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/ui/home/bloc/home_bloc.dart';
import 'package:e_commerce/ui/product_detail/bloc/product_details_bloc.dart';
import 'package:e_commerce/ui/product_detail/view/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/product/product_card.dart';
import '../../../../components/skleton/product/products_skelton.dart';
import '../../../../models/product_model.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/debug.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    super.key,
    required this.productStatus,
    this.products, required this.context,
});
final BuildContext context;
  final HomeStatus productStatus;
  final List<Products>? products;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Popular products",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        productStatus.isProductLoading||productStatus.isInitial||productStatus.productFailure||products==null?const ProductsSkelton():
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoPopularProducts on models/ProductModel.dart
            itemCount: products!.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == products!.length - 1
                    ? defaultPadding
                    : 0,
              ),
              child: ProductCard(
                image: products![index].image!,
                brandName: products![index].category!,
                title: products![index].title!,
                price: products![index].price!,
                priceAfetDiscount: double.parse((products![index].price!-((products![index].price!*10)/100)).toStringAsFixed(2)),
                dicountpercent: 10,
                press: () {
                  Navigator.push(context,ProductDetailsScreen.route(productId: products![index].id!)).then((_){
                    Debug.printLog("then");
                    if(this.context.mounted) {
                      Debug.printLog("then1");
                            this.context.read<HomeBloc>().add(GetItemCount());
                          }
                        });
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
