import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constant.dart';
import '../../bloc/checkout_bloc.dart';

class ShippingInformationForm extends StatelessWidget {
  const ShippingInformationForm({
    super.key,
    required this.formKey,
    required this.enabled,
    required this.nameTextEditingController,
    required this.addressTextEditingController,
    required this.cityTextEditingController,
    required this.stateTextEditingController,
    required this.zipTextEditingController,
  });

  final GlobalKey<FormState> formKey;
  final bool enabled;
  final TextEditingController nameTextEditingController;
  final TextEditingController addressTextEditingController;
  final TextEditingController cityTextEditingController;
  final TextEditingController stateTextEditingController;
  final TextEditingController zipTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameTextEditingController,
            enabled: enabled,
            validator: userValidator.call,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: addressTextEditingController,
            enabled: enabled,
            validator: userValidator.call,
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: cityTextEditingController,
            enabled: enabled,
            validator: userValidator.call,
            decoration: const InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: stateTextEditingController,
            enabled: enabled,
            validator: userValidator.call,
            decoration: const InputDecoration(
              labelText: 'State',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: zipTextEditingController,
            enabled: enabled,
            validator: userValidator.call,
            decoration: const InputDecoration(
              labelText: 'Zip',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
