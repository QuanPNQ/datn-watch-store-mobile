import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/product/product_event.dart';
import 'package:flutter_mob/blocs/product/product_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/card/card_fake_top_deel.dart';
import 'package:flutter_mob/ui/components/card/card_top_deel.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class TopDeels extends StatefulWidget {
  const TopDeels({super.key});

  @override
  State<TopDeels> createState() => _TopDeelsState();
}

class _TopDeelsState extends State<TopDeels>
    with AutomaticKeepAliveClientMixin {
  PageController pageController = PageController();
  List<Watch> listWatch = [];
  final List<Watch> listMockWatch = Constants.listMockDataWatch;
  bool isLoaded = false;

  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context)
        .add(GetTopDeelProductEvent(limit: 5, page: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) async {
        if (state is GetTopDeelProductLoadingState) {
          if (state.isViewAll) return;

          setState(() {
            isLoaded = false;
          });
        } else if (state is GetTopDeelProductSuccessState) {
          if (state.isViewAll) return;

          setState(() {
            isLoaded = true;
            listWatch = state.listWatch;
          });
        } else if (state is GetTopDeelProductErrorState) {}
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextNormal(
                  title: StringName.topDeels,
                  fontName: AppThemes.dmSerifDisplay,
                  size: 22,
                  lineHeight: 1.2,
                  colors: AppColors.black1,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Constants.allTopDeelsScreen);
                  },
                  child: TextNormal(
                    title: StringName.all,
                    size: 14,
                    lineHeight: 1.5,
                    colors: AppColors.blue300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 139,
            child: PageView(
              controller: pageController,
              children: isLoaded
                  ? listWatch
                      .map((e) => CardTopDeel(
                            watchData: e,
                            onClick: () {
                              handleClickTopDeel(e);
                            },
                          ))
                      .toList()
                  : listMockWatch.map((e) => CardFakeTopDeel()).toList(),
            ),
          )
        ],
      ),
    );
  }

  handleClickTopDeel(Watch watch) {
    BlocProvider.of<ProductBloc>(context)
        .add(GetDetailProductEvent(watchId: watch.id));
  }

  @override
  bool get wantKeepAlive => true;
}
