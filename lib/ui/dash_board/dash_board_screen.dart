import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/cart/cart_bloc.dart';
import 'package:flutter_mob/blocs/cart/cart_event.dart';
import 'package:flutter_mob/blocs/cart/cart_state.dart';
import 'package:flutter_mob/blocs/notify/notify_bloc.dart';
import 'package:flutter_mob/blocs/notify/notify_event.dart';
import 'package:flutter_mob/blocs/notify/notify_state.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/product/product_state.dart';
import 'package:flutter_mob/blocs/search_histories/search_histories_bloc.dart';
import 'package:flutter_mob/blocs/search_histories/search_histories_event.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/tab/tab_dashboard.dart';
import 'package:flutter_mob/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/ui/dash_board/cart/cart_screen.dart';
import 'package:flutter_mob/ui/dash_board/home/home_screen.dart';
import 'package:flutter_mob/ui/dash_board/personal_screen/personal_screen.dart';
import 'package:flutter_mob/ui/dash_board/search/search_screen.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  PageController pageController = PageController();
  int quantityCart = 0;
  int quantityNotify = 0;
  final List<TabDashboard> lisTab = [
    TabDashboard(
        icon: AppImages.iconHome, view: HomeScreen(), isSelected: true),
    TabDashboard(icon: AppImages.iconSearch, view: SearchScreen()),
    TabDashboard(icon: AppImages.iconShoppingBag, view: CardScreen()),
    TabDashboard(icon: AppImages.iconUser, view: PersonalScreen()),
  ];

  @override
  void initState() {
    LoadingHelper.hideLoading(context);
    BlocProvider.of<CartBloc>(context).add(GetListCartEvent());
    BlocProvider.of<NotifyBloc>(context).add(GetListNotifyEvent());
    BlocProvider.of<SearchHistoriesBloc>(context)
        .add(GetListSearchHistoriesEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotifyBloc, NotifyState>(
      listener: (context, state) async {
        if (state is GetListNotifySuccessState) {
          quantityNotify =
              state.listNotify.where((item) => item.isRead != true).length;
          SharedPrefManager? sharedPrefManager =
              await SharedPrefManager.getInstance();
          await sharedPrefManager!
              .putInt(SharedPrefManager.notifyKey, quantityNotify);
          setState(() {});
        } else if (state is ReadNotifySuccessState) {
          quantityNotify = state.quantityNotifyUnread;
          SharedPrefManager? sharedPrefManager =
              await SharedPrefManager.getInstance();
          await sharedPrefManager!
              .putInt(SharedPrefManager.notifyKey, quantityNotify);
          setState(() {});
        }
      },
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) async {
          if (state is GetListCartSuccessState) {
            setState(() {
              quantityCart = state.listCart.length;
            });
          }
        },
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) async {
            if (state is GetDetailProductLoadingState) {
              LoadingHelper.showLoading(context);
            } else if (state is GetDetailProductSuccessState) {
              LoadingHelper.hideLoading(context);
              Navigator.pushNamed(context, Constants.watchDetailScreen,
                  arguments: state.watch);
            } else if (state is GetDetailProductErrorState) {
              LoadingHelper.hideLoading(context);
            } else if (state is UpdateProductToCartLoadingState) {
              if (state.isShowToast) {
                LoadingHelper.showLoading(context);
              }
            } else if (state is UpdateProductToCartSuccessState) {
              LoadingHelper.hideLoading(context);
              setState(() {
                quantityCart = state.listCart.length;
              });
              if (state.type == UpdateCartTypeEnum.PLUS && state.isShowToast) {
                Fluttertoast.showToast(
                    msg: "Đã thêm vào giỏ hàng",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            } else if (state is UpdateProductToCartErrorState) {
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
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.gray900,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: lisTab.map((e) => e.view).toList(),
                ),
                SafeArea(
                  child: Container(
                    height: 58,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.yellow1,
                    ),
                    child: Row(
                      children: lisTab.map((e) {
                        int index = lisTab.indexOf(e);
                        return Expanded(
                            child: GestureDetector(
                          onTap: () => onClickTab(e),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                color: Colors.transparent,
                                child: SvgPicture.asset(e.icon,
                                    color: e.isSelected
                                        ? AppColors.blue300
                                        : AppColors.black2),
                              ),
                              if (quantityCart > 0 && index == 2)
                                Container(
                                  height: 16,
                                  width: 16,
                                  margin: EdgeInsets.only(top: 6, left: 24),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  child: TextNormal(
                                      title: quantityCart.toString(),
                                      fontName: AppThemes.sourceSans,
                                      lineHeight: 1,
                                      size: 12),
                                ),
                              if (quantityNotify > 0 && index == 3)
                                Container(
                                  height: 16,
                                  width: 16,
                                  margin: EdgeInsets.only(top: 6, left: 24),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  child: TextNormal(
                                      title: quantityNotify.toString(),
                                      fontName: AppThemes.sourceSans,
                                      lineHeight: 1,
                                      size: 12),
                                ),
                              if (e.isSelected)
                                Container(
                                  height: 5,
                                  width: 5,
                                  margin: EdgeInsets.only(top: 43),
                                  decoration: BoxDecoration(
                                      color: AppColors.blue300,
                                      shape: BoxShape.circle),
                                )
                            ],
                          ),
                        ));
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onClickTab(TabDashboard tabDashboard) async {
    if (tabDashboard.isSelected) return;

    int index = lisTab.indexOf(tabDashboard);
    pageController.jumpToPage(index);
    lisTab[index].isSelected = true;
    for (var i = 0; i < lisTab.length; i++) {
      if (i != index) {
        lisTab[i].isSelected = false;
      }
    }
    setState(() {});
  }
}
