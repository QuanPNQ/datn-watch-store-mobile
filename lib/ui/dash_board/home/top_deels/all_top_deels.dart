import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/product/product_event.dart';
import 'package:flutter_mob/blocs/product/product_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/card/card_fake_watch.dart';
import 'package:flutter_mob/ui/components/card/card_watch.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';

class AllTopDeelsScreen extends StatefulWidget {
  const AllTopDeelsScreen({super.key});

  @override
  State<AllTopDeelsScreen> createState() => _AllTopDeelsScreenState();
}

class _AllTopDeelsScreenState extends State<AllTopDeelsScreen> {
  bool isLoaded = false;
  List<Watch> listWatch = [];
  final List<Watch> listMockWatch =
      Constants.listMockDataWatch + Constants.listMockDataWatch;

  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context)
        .add(GetTopDeelProductEvent(limit: 50, page: 1, isViewAll: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) async {
        if (state is GetTopDeelProductLoadingState) {
          if (!state.isViewAll) return;

          setState(() {
            isLoaded = false;
          });
        } else if (state is GetTopDeelProductSuccessState) {
          if (!state.isViewAll) return;

          setState(() {
            isLoaded = true;
            listWatch = state.listWatch;
          });
        } else if (state is GetTopDeelProductErrorState) {
          if (!state.isViewAll) return;

          setState(() {
            isLoaded = true;
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: SafeArea(
          child: Column(
            children: [
              AppBarTitle(appTitle: StringName.topDeels),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ScrollConfiguration(
                    behavior: CustomScrollBehavior(),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 24,
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
                                            (MediaQuery.of(context).size.width -
                                                    60) /
                                                2,
                                        heightCard: 260,
                                        onClick: onCLickDetailWatch,
                                      ))
                                  .toList()
                              : listMockWatch
                                  .map((e) => CardFakeWatch(
                                        isShowAddButton: false,
                                        widthCard:
                                            (MediaQuery.of(context).size.width -
                                                    60) /
                                                2,
                                        heightCard: 260,
                                      ))
                                  .toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onCLickDetailWatch(Watch watch) {
    BlocProvider.of<ProductBloc>(context)
        .add(GetDetailProductEvent(watchId: watch.id));
  }
}
