import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/Banner/S/banner_s_style_1.dart';
import '../../../components/Banner/S/banner_s_style_5.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetAllCategory());
    context.read<HomeBloc>().add(GetAllProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.homeStatus.productFailure && state.errorMessage.isNotEmpty) {
            // Show error message
            Utils.showSnackBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                 SliverToBoxAdapter(child: OffersCarouselAndCategories(categoryStatus: state.homeStatus,category:state.category)),
                 SliverToBoxAdapter(child: PopularProducts(productStatus: state.homeStatus,products: state.products)),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
                  sliver: SliverToBoxAdapter(child: FlashSale()),
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
                const SliverToBoxAdapter(child: BestSellers()),
                const SliverToBoxAdapter(child: MostPopular()),
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
                const SliverToBoxAdapter(child: BestSellers()),
              ],
            ),
          );
        },
      ),
    );
  }
}
