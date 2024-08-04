import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/order/order_bloc.dart';
import 'package:flutter_mob/blocs/order/order_event.dart';
import 'package:flutter_mob/blocs/order/order_state.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/product/product_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/account/account.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/models/option.dart';
import 'package:flutter_mob/repositories/authentication/auth_repository.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/app_bar/header_navigation_bar.dart';
import 'package:flutter_mob/ui/components/card/card_order_verify.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Option> listTabTitle = Constants.listTabOrders;
  List<Order> listOrder = [];
  int currentIndex = 0;
  String accountId = '';

  @override
  void initState() {
    initData();
    BlocProvider.of<OrderBloc>(context)
        .add(GetListOrderEvent(status: OrderStatusType.PENDING));
    super.initState();
  }

  initData() async {
    Account? account = await AuthRepository().getUser();
    if (account != null) {
      accountId = account.id!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) async {
        if (state is EvaluateProductLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is EvaluateProductSuccessState) {
          BlocProvider.of<OrderBloc>(context)
              .add(GetListOrderEvent(status: listTabTitle[currentIndex].key));
        } else if (state is EvaluateProductErrorState) {
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
      child: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) async {
          if (state is OrderLoadingState) {
            LoadingHelper.showLoading(context);
          } else if (state is GetListOrderSuccessState) {
            LoadingHelper.hideLoading(context);
            setState(() {
              listOrder = state.orders;
            });
          } else if (state is GetListOrderErrorState) {
            LoadingHelper.hideLoading(context);
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is CancelOrderSuccessState) {
            BlocProvider.of<OrderBloc>(context)
                .add(GetListOrderEvent(status: listTabTitle[currentIndex].key));
          } else if (state is CancelOrderErrorState) {
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
                    appTitle: StringName.listOrder,
                    fontName: AppThemes.jaldi,
                    fontSize: 20),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      HeaderNavigationBar(
                          listTab: listTabTitle, onTabSelected: onTabSelected),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Container(
                          color: AppColors.oPrimaryColor,
                          child: ScrollConfiguration(
                            behavior: CustomScrollBehavior(),
                            child: ListView(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (listOrder.isNotEmpty)
                                      ...listOrder
                                          .map((e) => CardOrderVerify(
                                                order: e,
                                                accountId: accountId,
                                                onClick: () =>
                                                    handleViewDetailOrder(e),
                                              ))
                                          .toList(),
                                    if (listOrder.isEmpty)
                                      Container(
                                        margin: EdgeInsets.only(top: 100),
                                        child: TextNormal(
                                          title: StringName.noOrder,
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.spectral,
                                          size: 18,
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTabSelected(int index) {
    setState(() {
      listOrder.clear();
      currentIndex = index;
    });
    BlocProvider.of<OrderBloc>(context)
        .add(GetListOrderEvent(status: listTabTitle[index].key));
  }

  handleViewDetailOrder(Order order) async {
    LoadingHelper.showLoading(context);
    await Future.delayed(Duration(seconds: 2));
    LoadingHelper.hideLoading(context);
    var data = {"order": order};
    Navigator.pushNamed(context, Constants.detailOrderScreen, arguments: data);
  }
}
