import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/assets.dart';
import '../../bloc/checkout_bloc.dart';

class PaymentMethodSelection extends StatelessWidget {
  const PaymentMethodSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Credit Card'),
          leading: SvgPicture.asset(
            Assets.iconsAtmCard,
            height: 30,
            width: 30,
          ),
          trailing: Radio(
            value: 'Credit Card',
            groupValue: context.watch<CheckoutBloc>().state.paymentMethod,
            onChanged: (value) {
              context
                  .read<CheckoutBloc>()
                  .add(SelectPaymentMethod(paymentMethod: value!));
            },
          ),
        ),
        ListTile(
          title: const Text('Debit Card'),
          leading: SvgPicture.asset(
            Assets.iconsAtmCard,
            height: 30,
            width: 30,
          ),
          trailing: Radio(
            value: 'Debit Card',
            groupValue: context.watch<CheckoutBloc>().state.paymentMethod,
            onChanged: (value) {
              context
                  .read<CheckoutBloc>()
                  .add(SelectPaymentMethod(paymentMethod: value!));
            },
          ),
        ),
        ListTile(
          title: const Text('PayPal'),
          leading: SvgPicture.asset(
            Assets.iconsPaypal,
            height: 30,
            width: 30,
          ),
          trailing: Radio(
            value: 'PayPal',
            groupValue: context.watch<CheckoutBloc>().state.paymentMethod,
            onChanged: (value) {
              context
                  .read<CheckoutBloc>()
                  .add(SelectPaymentMethod(paymentMethod: value!));
            },
          ),
        ),
        ListTile(
          title: const Text('PhonePay'),
          leading: SvgPicture.asset(
            Assets.iconsPhonepAY,
            height: 30,
            width: 30,
          ),
          trailing: Radio(
            value: 'PhonePay',
            groupValue: context.watch<CheckoutBloc>().state.paymentMethod,
            onChanged: (value) {
              context
                  .read<CheckoutBloc>()
                  .add(SelectPaymentMethod(paymentMethod: value!));
            },
          ),
        ),
        ListTile(
          title: const Text('GPay'),
          leading: SvgPicture.asset(
            Assets.iconsGooglepay,
            height: 30,
            width: 30,
          ),
          trailing: Radio(
            value: 'GPay',
            groupValue: context.watch<CheckoutBloc>().state.paymentMethod,
            onChanged: (value) {
              context
                  .read<CheckoutBloc>()
                  .add(SelectPaymentMethod(paymentMethod: value!));
            },
          ),
        ),
      ],
    );
  }
}

const creditCard =
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <rect x="3" y="3" width="18" height="18" rx="2" fill="#fff" />
  <path d="M12 12L15 15M15 15L18 12M18 12L15 9M15 9L12 12" stroke="#fff" stroke-width="2" />
</svg>
''';

const debitCard =
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <rect x="3" y="3" width="18" height="18" rx="2" fill="#fff" />
  <path d="M12 12L15 15M15 15L18 12M18 12L15 9M15 9L12 12" stroke="#fff" stroke-width="2" />
  <circle cx="12" cy="12" r="2" fill="#fff" />
</svg>
''';

const payPal =
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2Z" fill="#fff" />
  <path d="M12 8L12 16M12 16L15 13M15 13L12 10M12 10L9 13M9 13L12 16" stroke="#fff" stroke-width="2" />
</svg>
''';

const gPay =
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2Z" fill="#fff" />
  <path d="M12 8L12 16M12 16L15 13M15 13L12 10M12 10L9 13M9 13L12 16" stroke="#fff" stroke-width="2" />
  <circle cx="12" cy="12" r="4" fill="#fff" />
</svg>
''';

const phonePay =
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <rect x="3" y="3" width="18" height="18" rx="2" fill="#fff" />
  <path d="M12 12L15 15M15 15L18 12M18 12L15 9M15 9L12 12" stroke="#fff" stroke-width="2" />
  <circle cx="12" cy="12" r="2" fill="#fff" />
  <path d="M12 8L12 16" stroke="#fff" stroke-width="2" />
</svg>
''';
