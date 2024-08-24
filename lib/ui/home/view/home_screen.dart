import 'dart:math';

import 'package:e_commerce/utils/debug.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/Banner/S/banner_s_style_1.dart';
import '../../../components/Banner/S/banner_s_style_5.dart';
import '../../../generated/assets.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../cart/view/cart_screen.dart';
import '../bloc/home_bloc.dart';
import 'components/best_sellers.dart';
import 'components/flash_sale.dart';
import 'components/most_popular.dart';
import 'components/offer_carousel_and_categories.dart';
import 'components/popular_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Route<void> route(String? data) {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
              create: (_) => HomeBloc(),
              child: const HomeScreen(),
            ));
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random = Random();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetItemCount());
    context.read<HomeBloc>().add(GetAllCategory());
    context.read<HomeBloc>().add(GetAllProduct());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.homeStatus.productFailure && state.errorMessage.isNotEmpty) {
          // Show error message
          Utils.showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        Debug.printLog("stat : ${state.itemCount}");
        return Scaffold(
            appBar: AppBar(
              // pinned: true,
              // floating: true,
              // snap: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: const SizedBox(),
              leadingWidth: 0,
              centerTitle: false,
              title: SvgPicture.asset(
                Assets.logoShoplon,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!, BlendMode.srcIn),
                height: 20,
                width: 100,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, CartScreen.route()).then((_){
                     if(context.mounted) context.read<HomeBloc>().add(GetItemCount());
                    });
                  },
                  icon: Badge(
                    backgroundColor: primaryColor,
                    label: Text(
                      state.itemCount.toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    child: SvgPicture.asset(
                      Assets.iconsChild,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).textTheme.bodyLarge!.color!,
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: OffersCarouselAndCategories(
                          categoryStatus: state.homeStatus,
                          category: state.category,
                          context: context)),
                  SliverToBoxAdapter(
                      child: PopularProducts(
                    productStatus: state.homeStatus,
                    products: state.products,
                    context: context,
                  )),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 1.5),
                    sliver: SliverToBoxAdapter(
                        child: FlashSale(
                            context: context,
                            productStatus: state.homeStatus,
                            products: (state.products?.toList()
                                  ?..shuffle(random))
                                ?.sublist(0, 3))),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        // While loading use 👇
                        // const BannerMSkelton(),‚
                        BannerSStyle1(
                          title: "New \narrival",
                          subtitle: "SPECIAL OFFER",
                          discountParcent: 50,
                          press: () {
                            // Navigator.pushNamed(context, onSaleScreenRoute);
                          },
                        ),
                        const SizedBox(height: defaultPadding / 4),
                        // We have 4 banner styles, all in the pro version
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: BestSellers(
                          context: context,
                          productStatus: state.homeStatus,
                          products: (state.products?.toList()?..shuffle(random))
                              ?.sublist(0, 3))),
                  SliverToBoxAdapter(
                      child: MostPopular(
                          context: context,
                          productStatus: state.homeStatus,
                          products: (state.products?.toList()?..shuffle(random))
                              ?.sublist(0, 7))),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: defaultPadding * 1.5),

                        const SizedBox(height: defaultPadding / 4),
                        // While loading use 👇
                        // const BannerSSkelton(),
                        BannerSStyle5(
                          title: "Black \nfriday",
                          subtitle: "50% Off",
                          bottomText: "Collection".toUpperCase(),
                          press: () {
                            // Navigator.pushNamed(context, onSaleScreenRoute);
                          },
                        ),
                        const SizedBox(height: defaultPadding / 4),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
