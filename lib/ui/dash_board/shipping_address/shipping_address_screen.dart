import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_bloc.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_event.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/shipping_address/shipping_address.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/card/card_shipping_address.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddressScreen> {
  List<ShippingAddress> listShippingAddress = [];
  bool isSuccess = false;

  @override
  void initState() {
    BlocProvider.of<ShippingAddressBloc>(context)
        .add(GetListAddressEvent(indexPage: 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShippingAddressBloc, ShippingAddressState>(
      listener: (context, state) async {
        if (state is ShippingAddressLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is SetDefaultAddressSuccessState) {
          LoadingHelper.hideLoading(context);
          if (state.isPop) {
            Navigator.pop(context, state.shippingAddress);
          }
        } else if (state is GetListAddressSuccessState) {
          if (state.indexPage == 2) {
            LoadingHelper.hideLoading(context);
            setState(() {
              isSuccess = true;
              listShippingAddress = state.listAddress;
              var indexShippingAddress = listShippingAddress
                  .indexWhere((element) => element.isDefault);
              if (indexShippingAddress < 0 && listShippingAddress.length > 0) {
                listShippingAddress.first.isDefault = true;
                BlocProvider.of<ShippingAddressBloc>(context).add(
                    SetDefaultAddressEvent(
                        shippingAddress: listShippingAddress.first,
                        isPop: false));
              }
            });
          }
        } else if (state is GetListAddressErrorState) {
          if (state.indexPage == 2) {
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
        } else if (state is SetDefaultAddressErrorState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: SafeArea(
          child: Column(
            children: [
              AppBarTitle(
                appTitle: StringName.listShippingAddress,
                onPop: () {
                  ShippingAddress? defaultShippingAddress;
                  var indexShippingAddress = listShippingAddress
                      .indexWhere((element) => element.isDefault);
                  if (indexShippingAddress < 0 &&
                      listShippingAddress.length > 0) {
                    defaultShippingAddress = listShippingAddress.first;
                  } else if (listShippingAddress.length > 0) {
                    defaultShippingAddress =
                        listShippingAddress[indexShippingAddress];
                  }
                  Navigator.pop(
                      context,
                      defaultShippingAddress != null
                          ? defaultShippingAddress
                          : false);
                },
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
                                  TextNormal(
                                    title: StringName.address,
                                    colors: AppColors.bPrimaryColor,
                                    fontName: AppThemes.jaldi,
                                  ),
                                  ...listShippingAddress.map((e) {
                                    return CardShippingAddress(
                                      shippingAddress: e,
                                      onSelectAddress: (shippingAddress) {
                                        BlocProvider.of<ShippingAddressBloc>(
                                                context)
                                            .add(SetDefaultAddressEvent(
                                                shippingAddress:
                                                    shippingAddress,
                                                isPop: true));
                                      },
                                      onUpdateAddress: (shippingAddress) async {
                                        var result = await Navigator.pushNamed(
                                            context,
                                            Constants.newShippingAddressScreen,
                                            arguments: shippingAddress);
                                        if (result != null) {
                                          BlocProvider.of<ShippingAddressBloc>(
                                                  context)
                                              .add(GetListAddressEvent(
                                                  indexPage: 2));
                                        }
                                      },
                                    );
                                  }).toList(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ButtonNormal(
                                    text: StringName.newAddress,
                                    onPressed: handleAddNewAddress,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleAddNewAddress() async {
    var result =
        await Navigator.pushNamed(context, Constants.newShippingAddressScreen);
    if (result != null) {
      BlocProvider.of<ShippingAddressBloc>(context)
          .add(GetListAddressEvent(indexPage: 2));
    }
  }
}
