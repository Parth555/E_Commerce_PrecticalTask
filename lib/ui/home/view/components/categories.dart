import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constant.dart';
import '../../../../utils/utils.dart';
import '../../../category_products/view/category_product_screen.dart';
import '../../bloc/home_bloc.dart';

// For preview
class CategoryModel {
  final String name;
  final String? svgSrc, route;

  CategoryModel({
    required this.name,
    this.svgSrc,
    this.route,
  });
}

List<CategoryModel> demoCategories = [
  // CategoryModel(name: "All Categories"),
  // CategoryModel(
  //     name: "On Sale",
  //     svgSrc: "assets/icons/Sale.svg",
  //     route: onSaleScreenRoute),
  CategoryModel(name: "Man's", svgSrc: "assets/icons/Man.svg"),
  CategoryModel(name: "Woman’s", svgSrc: "assets/icons/Woman.svg"),
  CategoryModel(name: "Man's", svgSrc: "assets/icons/Man.svg"),
  CategoryModel(name: "Woman’s", svgSrc: "assets/icons/Woman.svg"),
  CategoryModel(name: "Man's", svgSrc: "assets/icons/Man.svg"),
  // CategoryModel(
  //     name: "Kids", svgSrc: "assets/icons/Child.svg", route: kidsScreenRoute),
];
// End For Preview

class Categories extends StatelessWidget {
  final List<String> category;

  const Categories({
    super.key, required this.category, required this.context,
  });
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            category.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? defaultPadding : defaultPadding / 2,
                  right:
                      index == category.length - 1 ? defaultPadding : 0),
              child: CategoryBtn(
                category: Utils.capitalizeFirstLetter(category[index]),
                isActive: true,
                press: () {
                    Navigator.push(context, ProductCategoryScreen.route(category: category[index])).then((_){
                     if(this.context.mounted) this.context.read<HomeBloc>().add(GetItemCount());
                    });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.category,
    this.svgSrc,
    required this.isActive,
    required this.press,
  });

  final String category;
  final String? svgSrc;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            if (svgSrc != null)
              SvgPicture.asset(
                svgSrc!,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
            if (svgSrc != null) const SizedBox(width: defaultPadding / 2),
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
