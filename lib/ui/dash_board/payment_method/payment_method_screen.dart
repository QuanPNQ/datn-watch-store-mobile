import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/card/card_payment_method.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String? paymentMethod;

  const PaymentMethodScreen({super.key, this.paymentMethod});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethodScreen> {
  List<String> listPaymentMethod = [
    PaymentMethodType.CASH.name,
    PaymentMethodType.VNPAY.name
  ];

  String? paymentMethodSelected;

  @override
  void initState() {
    paymentMethodSelected = widget.paymentMethod;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarTitle(
              appTitle: StringName.selectPaymentMethod,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          ...listPaymentMethod.map((e) {
                            return CardPaymentMethod(
                              paymentMethod: e,
                              isSelected: paymentMethodSelected == e,
                              onSelectPaymentMethod: (method) {
                                setState(() {
                                  paymentMethodSelected = method;
                                });
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17, bottom: 20),
              child: ButtonNormal(
                text: StringName.agree,
                onPressed: handleConfirm,
                enabled: paymentMethodSelected != null,
                borderColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleConfirm() async {
    Navigator.pop(context, paymentMethodSelected);
  }
}
