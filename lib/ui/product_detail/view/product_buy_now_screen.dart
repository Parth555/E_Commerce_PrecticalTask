import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/ui/product_detail/view/components/product_list_tile.dart';
import 'package:e_commerce/ui/product_detail/view/components/product_quantity.dart';
import 'package:e_commerce/ui/product_detail/view/components/selected_colors.dart';
import 'package:e_commerce/ui/product_detail/view/components/selected_size.dart';
import 'package:e_commerce/ui/product_detail/view/components/unit_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/cart_button.dart';
import '../../../components/custom_modal_bottom_sheet.dart';
import '../../../components/network_image_with_loader.dart';
import '../../../generated/assets.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../widgets/alert_dialog_widget.dart';
import '../bloc/product_details_bloc.dart';
import 'added_to_cart_message_screen.dart';

class ProductBuyNowScreen extends StatefulWidget {
  final Products product;

  final BuildContext context;

  const ProductBuyNowScreen(
      {super.key, required this.product, required this.context});

  @override
  ProductBuyNowScreenState createState() => ProductBuyNowScreenState();
}

class ProductBuyNowScreenState extends State<ProductBuyNowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
        bloc: widget.context.read<ProductDetailsBloc>(),
        builder: (context, state) {
          return CartButton(
            price: (double.parse((widget.product.price! -
                        ((widget.product.price! * 10) / 100))
                    .toStringAsFixed(2))) *
                state.itemCount,
            title: "Add to cart",
            subTitle: "Total price",
            press: () {
              if (state.itemCount == 0) {
                Utils.showSnackBar(context, 'Please increase item count');
                return;
              }
              widget.context.read<ProductDetailsBloc>().add(ItemAddToCart(
                    widget.product,
                    state.itemCount,
                    state.selectedColour,
                    state.selectedSize,
                  ));
            },
          );
        },
        listener: (BuildContext context, ProductDetailsState state) {
          if (state.addToCartStatus.isAddToCartLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AlertDialogWidget(),
            );
          }
          if (state.addToCartStatus.isAddToCartSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            customModalBottomSheet(
              context,
              isDismissible: false,
              child: const AddedToCartMessageScreen(),
            );
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2, vertical: defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Expanded(
                  child: Text(
                    maxLines: 2,
                    widget.product.title ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(Assets.iconsBookmark,
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: NetworkImageWithLoader(widget.product.image!,
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                      bloc: widget.context.read<ProductDetailsBloc>(),
                      builder: (context, state) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: UnitPrice(
                                price: (widget.product.price ?? 0.0) *
                                    state.itemCount,
                                priceAfterDiscount: (double.parse(
                                        (widget.product.price! -
                                                ((widget.product.price! * 10) /
                                                    100))
                                            .toStringAsFixed(2))) *
                                    state.itemCount,
                              ),
                            ),
                            ProductQuantity(
                              numOfItem: state.itemCount,
                              onIncrement: () {
                                widget.context
                                    .read<ProductDetailsBloc>()
                                    .add(IncrementItem(state.itemCount));
                              },
                              onDecrement: () {
                                widget.context
                                    .read<ProductDetailsBloc>()
                                    .add(DecrementItem(state.itemCount));
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(
                  child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                    bloc: widget.context.read<ProductDetailsBloc>(),
                    builder: (context, state) {
                      return SelectedColors(
                        colors: itemColors,
                        selectedColorIndex: state.selectedColour,
                        press: (value) {
                          widget.context
                              .read<ProductDetailsBloc>()
                              .add(SelectedColour(value));
                        },
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                    bloc: widget.context.read<ProductDetailsBloc>(),
                    builder: (context, state) {
                      return SelectedSize(
                        sizes: itemSize,
                        selectedIndex: state.selectedSize,
                        press: (value) {
                          widget.context
                              .read<ProductDetailsBloc>()
                              .add(SelectedSizeIndex(value));
                        },
                      );
                    },
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  sliver: ProductListTile(
                    title: "Size guide",
                    svgSrc: "assets/icons/Sizeguid.svg",
                    isShowBottomBorder: true,
                    press: () {
                      // customModalBottomSheet(
                      //   context,
                      //   height: MediaQuery.of(context).size.height * 0.9,
                      //   child: const SizeGuideScreen(),
                      // );
                    },
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: defaultPadding / 2),
                        Text(
                          "Store pickup availability",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        const Text(
                            "Select a size to check store availability and In-Store pickup options.")
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  sliver: ProductListTile(
                    title: "Check stores",
                    svgSrc: "assets/icons/Stores.svg",
                    isShowBottomBorder: true,
                    press: () {
                      // customModalBottomSheet(
                      //   context,
                      //   height: MediaQuery.of(context).size.height * 0.92,
                      //   child: const LocationPermissonStoreAvailabilityScreen(),
                      // );
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding))
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
