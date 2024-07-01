import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/product/product_event.dart';
import 'package:flutter_mob/blocs/product/product_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/card/card_fake_watch.dart';
import 'package:flutter_mob/ui/components/card/card_watch.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class OutstandingWatch extends StatefulWidget {
  const OutstandingWatch({super.key});

  @override
  State<OutstandingWatch> createState() => _OutstandingWatchState();
}

class _OutstandingWatchState extends State<OutstandingWatch>
    with AutomaticKeepAliveClientMixin {
  List<Watch> listWatch = [];
  final List<Watch> listMockWatch = Constants.listMockDataWatch;
  bool isLoaded = false;

  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context)
        .add(GetOutstandingProductEvent(limit: 10, page: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) async {
        if (state is GetOutstandingProductLoadingState) {
          if (state.isViewAll) return;

          setState(() {
            isLoaded = false;
          });
        } else if (state is GetOutstandingProductSuccessState) {
          if (state.isViewAll) return;

          setState(() {
            isLoaded = true;
            listWatch = state.listWatch;
          });
        } else if (state is GetOutstandingProductErrorState) {}
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
                  title: StringName.outstandingWatch,
                  fontName: AppThemes.dmSerifDisplay,
                  size: 22,
                  lineHeight: 1.2,
                  colors: AppColors.black1,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.allOutstandingScreen);
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
            height: 30,
          ),
          Wrap(
            runSpacing: 30,
            spacing: 20,
            children: isLoaded
                ? listWatch
                    .map((e) => CardWatch(
                          watchData: e,
                          isShowAddButton: false,
                          widthCard:
                              (MediaQuery.of(context).size.width - 60) / 2,
                          heightCard: 260,
                          onClick: onCLickDetailWatch,
                        ))
                    .toList()
                : listMockWatch
                    .map((e) => CardFakeWatch(
                          isShowAddButton: false,
                          widthCard:
                              (MediaQuery.of(context).size.width - 60) / 2,
                          heightCard: 260,
                        ))
                    .toList(),
          )
        ],
      ),
    );
  }

  onCLickDetailWatch(Watch watch) {
    BlocProvider.of<ProductBloc>(context)
        .add(GetDetailProductEvent(watchId: watch.id));
  }

  @override
  bool get wantKeepAlive => true;
}
