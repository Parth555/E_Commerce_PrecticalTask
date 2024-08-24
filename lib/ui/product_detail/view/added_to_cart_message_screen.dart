import 'package:e_commerce/generated/assets.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';
import '../../cart/view/cart_screen.dart';

class AddedToCartMessageScreen extends StatelessWidget {
  const AddedToCartMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                Theme.of(context).brightness == Brightness.light
                    ? Assets.illustrationSuccess
                    : Assets.illustrationSuccessDark,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const Spacer(flex: 2),
              Text(
                "Added to cart",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: defaultPadding / 2),
              const Text(
                "Click the checkout button to complete the purchase process.",
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Continue shopping"),
              ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, CartScreen.route());
                },
                child: const Text("Checkout"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
