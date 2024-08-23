import 'package:e_commerce/widgets/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../components/product/product_card.dart';
import '../../../components/skleton/product/product_card_skelton.dart';
import '../../../models/product_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../bloc/category_products_bloc.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({super.key, required this.category});

  final String category;

  static Route<void> route({required String category}) {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
              create: (_) => CategoryProductsBloc(),
              child: ProductCategoryScreen(category: category),
            ));
  }

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryProductsBloc>().add(GetAllProduct(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title: CommonText(text: widget.category.toUpperCase()),
      ),
      body: BlocConsumer<CategoryProductsBloc, CategoryProductsState>(
        listener: (context, state) {
          if (state.categoryStatus.categoryFailure && state.errorMessage.isNotEmpty) {
            // Show error message
            Utils.showSnackBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // While loading use 👇
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: defaultPadding,
                    crossAxisSpacing: defaultPadding,
                    childAspectRatio: 0.66,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return state.categoryStatus.categoryFailure || state.categoryStatus.isCategoryLoading || state.products == null
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade900,
                              highlightColor: Colors.grey.shade300,
                              enabled: true,
                              child: const ProductCardSkelton(),
                            )
                          : ProductCard(
                        image: state.products![index].image!,
                        brandName: state.products![index].category!,
                        title: state.products![index].title!,
                        price: state.products![index].price!,
                        priceAfetDiscount: double.parse((state.products![index].price!-((state.products![index].price!*10)/100)).toStringAsFixed(2)),
                        dicountpercent: 10,
                              press: () {
                                // Navigator.pushNamed(context, productDetailsScreenRoute);
                              },
                            );
                    },
                    childCount: state.products!=null?state.products!.length:4,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
