import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/discount/discount_bloc.dart';
import 'package:flutter_mob/blocs/discount/discount_event.dart';
import 'package:flutter_mob/blocs/discount/discount_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/discount/discount.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/card/card_discount.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApplyDiscountScreen extends StatefulWidget {
  final Discount? discount;

  const ApplyDiscountScreen({super.key, this.discount});

  @override
  State<ApplyDiscountScreen> createState() => _ApplyDiscountState();
}

class _ApplyDiscountState extends State<ApplyDiscountScreen> {
  List<Discount> listDiscount = [];
  Discount? discountSelected;
  bool isSuccess = false;

  @override
  void initState() {
    discountSelected = widget.discount;
    BlocProvider.of<DiscountBloc>(context).add(GetListDiscountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiscountBloc, DiscountState>(
      listener: (context, state) async {
        if (state is DiscountLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is GetListDiscountSuccessState) {
          LoadingHelper.hideLoading(context);
          setState(() {
            listDiscount = state.listDiscount;
            isSuccess = true;
          });
        } else if (state is DiscountErrorState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          isSuccess = false;
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: SafeArea(
          child: Column(
            children: [
              AppBarTitle(
                appTitle: StringName.selectVoucher,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ListView(
                    children: [
                      isSuccess
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 6,
                                  ),
                                  if (listDiscount.isNotEmpty)
                                    ...listDiscount.map((e) {
                                      return CardDiscount(
                                        discount: e,
                                        isSelected: discountSelected != null
                                            ? e.id == discountSelected!.id
                                            : false,
                                        onSelectDiscount: (discount) {
                                          setState(() {
                                            if (discountSelected != null &&
                                                discountSelected!.id ==
                                                    discount.id) {
                                              discountSelected = null;
                                            } else {
                                              discountSelected = discount;
                                            }
                                          });
                                        },
                                      );
                                    }).toList(),
                                  if (listDiscount.isEmpty)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: TextNormal(
                                            title: "Chưa có Voucher",
                                            colors: AppColors.bPrimaryColor,
                                            fontName: AppThemes.jaldi,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              if (listDiscount.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.only(left: 17, right: 17, bottom: 20),
                  child: ButtonNormal(
                    text: StringName.agree,
                    onPressed: handleConfirm,
                    borderColor: Colors.transparent,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  handleConfirm() async {
    Navigator.pop(context, discountSelected != null ? discountSelected : false);
  }
}
