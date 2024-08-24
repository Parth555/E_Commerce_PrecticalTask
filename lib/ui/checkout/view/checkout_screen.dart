import 'package:e_commerce/ui/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/custom_modal_bottom_sheet.dart';
import '../../../utils/utils.dart';
import '../../../widgets/alert_dialog_widget.dart';
import '../bloc/checkout_bloc.dart';
import 'componants/order_conformed_screen.dart';
import 'componants/payment_method_screen.dart';
import 'componants/shipping_info.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) =>
            BlocProvider(
              create: (_) => CheckoutBloc(),
              child: const CheckoutScreen(),
            ));
  }

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController nameTextEditingController =
  TextEditingController();
  final TextEditingController addressTextEditingController =
  TextEditingController();
  final TextEditingController cityTextEditingController =
  TextEditingController();
  final TextEditingController stateTextEditingController =
  TextEditingController();
  final TextEditingController zipTextEditingController =
  TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<CheckoutBloc>().add(GetAllCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if(state.isOrderLoading){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AlertDialogWidget(),
            );
          }
          if (state.isOrderConfirmed) {
            Navigator.pushAndRemoveUntil(context, HomeScreen.route(''), (Route<dynamic> route) => false);
            customModalBottomSheet(
              context,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.92,
              child: OrderConformedScreen(
                products: state.products,
                totalPrice: state.totalPrice,
                address: '${state.name},${state.address},${state.city},${state.state},${state.zip},',
                paymentType: state.paymentMethod,
                orderId:state.orderId
                ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ShippingInformationForm(
                    formKey: formKey,
                    enabled: true,
                    nameTextEditingController: nameTextEditingController,
                    addressTextEditingController: addressTextEditingController,
                    cityTextEditingController: cityTextEditingController,
                    stateTextEditingController: stateTextEditingController,
                    zipTextEditingController: zipTextEditingController,
                  ),
                  const SizedBox(height: 20),
                  const PaymentMethodSelection(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (state.paymentMethod.isEmpty) {
                          Utils.showSnackBar(
                              context, "Please select payment method");
                          return;
                        }
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateShippingInformation(
                          name: nameTextEditingController.text,
                          address: addressTextEditingController.text,
                          city: cityTextEditingController.text,
                          state: stateTextEditingController.text,
                          zip: zipTextEditingController.text,
                        ));
                        context.read<CheckoutBloc>().add(ConfirmOrder(
                            state.totalPrice,
                            '${nameTextEditingController
                                .text},${addressTextEditingController
                                .text},${cityTextEditingController
                                .text},${stateTextEditingController
                                .text},${zipTextEditingController.text}',
                            state.paymentMethod));
                      }
                    },
                    child: const Text('Confirm Order'),
                  ),
                  const SizedBox(height: 20),
                  OrderSummary(state: state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final CheckoutState state;

  const OrderSummary({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.isOrderConfirmed) {
      return Column(
        children: [
          const Text('Order Summary:'),
          Text('Name: ${state.name}'),
          Text('Address: ${state.address}'),
          Text('City: ${state.city}'),
          Text('State: ${state.state}'),
          Text('Zip: ${state.zip}'),
          Text('Payment Method: ${state.paymentMethod}'),
          const Text('Order Confirmed!'),
        ],
      );
    } else {
      return const Text('Please complete the checkout process.');
    }
  }
}
