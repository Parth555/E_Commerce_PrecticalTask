import 'package:flutter/material.dart';

import '../../../../components/skleton/others/categories_skelton.dart';
import '../../../../utils/constant.dart';
import '../../bloc/home_bloc.dart';
import 'categories.dart';
import 'offers_carousel.dart';

class OffersCarouselAndCategories extends StatelessWidget {
  const OffersCarouselAndCategories({
    super.key,
    required this.categoryStatus,
    this.category,
  });

  final HomeStatus categoryStatus;
  final List<String>? category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading use 👇
        // const OffersSkelton(),
        const OffersCarousel(),
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Categories",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇

        categoryStatus.isInitial ||
        categoryStatus.isCategoryLoading ||
        categoryStatus.categoryFailure ||category==null?
              const CategoriesSkelton()
            :  Categories(category:category!)
      ],
    );
  }
}
