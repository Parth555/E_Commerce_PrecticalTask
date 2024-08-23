import 'package:e_commerce/ui/product_detail/bloc/product_details_bloc.dart';
import 'package:e_commerce/ui/product_detail/view/product_buy_now_screen.dart';
import 'package:e_commerce/ui/product_detail/view/product_returns_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../components/buy_full_ui_kit.dart';
import '../../../components/cart_button.dart';
import '../../../components/custom_modal_bottom_sheet.dart';
import '../../../components/product/product_card.dart';
import '../../../components/skleton/product/product_card_skelton.dart';
import '../../../generated/assets.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import 'components/notify_me_card.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';
import 'components/product_list_tile.dart';
import '../../../components/review_card.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, this.isProductAvailable = true, required this.productId});

  final bool isProductAvailable;
  final int productId;

  static Route<void> route({required int productId}) {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
              create: (_) => ProductDetailsBloc(),
              child: ProductDetailsScreen(productId: productId),
            ));
  }

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsBloc>().add(GetProductDetail(widget.productId, context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            return widget.isProductAvailable
                ? state.product != null
                    ? CartButton(
                        price: 140,
                        press: () {
                          customModalBottomSheet(
                            context,
                            height: MediaQuery.of(context).size.height * 0.92,
                            child: ProductBuyNowScreen(product: state.product!,context: context),
                          );
                        },
                      )
                    : const SizedBox()
                :

                /// If profuct is not available then show [NotifyMeCard]
                NotifyMeCard(
                    isNotify: false,
                    onChanged: (value) {},
                  );
          },
          listener: (context, state) {}),
      body: SafeArea(
        child: BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
          listener: (context, state) {
            if (state.productStatus.productFailure && state.errorMessage.isNotEmpty) {
              // Show error message
              Utils.showSnackBar(context, state.errorMessage);
            }
            if (state.categoryStatus.productFailure && state.errorMessage.isNotEmpty) {
              // Show error message
              Utils.showSnackBar(context, state.errorMessage);
            }
            if (state.productStatus.isProductSuccess && state.product != null) {
              // ;
            }
          },
          builder: (context, state) {
            return state.product != null
                ? CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        floating: true,
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(Assets.iconsBookmark, color: Theme.of(context).textTheme.bodyLarge!.color),
                          ),
                        ],
                      ),
                      ProductImages(
                        images: [state.product!.image!, state.product!.image!, state.product!.image!],
                      ),
                      ProductInfo(
                        brand: state.product!.category!.toUpperCase(),
                        title: state.product!.title!,
                        isAvailable: widget.isProductAvailable,
                        description: state.product!.description!,
                        rating: state.product!.rating?.rate ?? 0.0,
                        numOfReviews: state.product!.rating?.count ?? 0,
                      ),
                      ProductListTile(
                        svgSrc: Assets.iconsReturn,
                        title: "Returns Policy",
                        isShowBottomBorder: true,
                        press: () {
                          customModalBottomSheet(
                            context,
                            height: MediaQuery.of(context).size.height * 0.92,
                            child: const ProductReturnsScreen(),
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: ReviewCard(
                            rating: state.product!.rating?.rate ?? 0.0,
                            numOfReviews: state.product!.rating?.count ?? 0,
                            numOfFiveStar: 80,
                            numOfFourStar: 30,
                            numOfThreeStar: 5,
                            numOfTwoStar: 4,
                            numOfOneStar: 1,
                          ),
                        ),
                      ),
                      ProductListTile(
                        svgSrc: "assets/icons/Chat.svg",
                        title: "Reviews",
                        isShowBottomBorder: true,
                        press: () {
                          // Navigator.pushNamed(context, productReviewsScreenRoute);
                        },
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(defaultPadding),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            "You may also like",
                            style: Theme.of(context).textTheme.titleSmall!,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.products != null ? state.products!.length : 5,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                              child: state.categoryStatus.categoryFailure || state.categoryStatus.isCategoryLoading || state.products == null
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
                                      priceAfetDiscount: double.parse(
                                          (state.products![index].price! - ((state.products![index].price! * 10) / 100)).toStringAsFixed(2)),
                                      dicountpercent: 10,
                                      press: () {
                                        Navigator.push(context, ProductDetailsScreen.route(productId: state.products![index].id!));
                                      },
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: defaultPadding),
                      )
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
