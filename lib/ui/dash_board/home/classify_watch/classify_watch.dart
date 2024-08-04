import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/product/product_event.dart';
import 'package:flutter_mob/blocs/product/product_state.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/option.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/app_bar/header_navigation_bar.dart';
import 'package:flutter_mob/ui/components/card/card_fake_watch.dart';
import 'package:flutter_mob/ui/components/card/card_watch.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';

class ClassifyWatch extends StatefulWidget {
  const ClassifyWatch({super.key});

  @override
  State<ClassifyWatch> createState() => _ClassifyWatchState();
}

class _ClassifyWatchState extends State<ClassifyWatch>
    with AutomaticKeepAliveClientMixin {
  final List<Option> listTabTitle = Constants.listTabClassifyWatch;
  final List<Watch> listMockWatch = Constants.listMockDataWatch;
  final List<TopProductType> listTopProductType = [
    TopProductType.SALE,
    TopProductType.POPULAR,
    TopProductType.NEW,
    TopProductType.COLLECTION
  ];
  List<Watch> listWatch = [];
  bool isLoaded = false;
  int indexSelected = 0;

  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(GetClassicProductEvent(
      limit: 5,
      page: 1,
      type: TopProductType.SALE,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) async {
        if (state is GetClassicProductLoadingState) {
          setState(() {
            isLoaded = false;
          });
        } else if (state is GetClassicProductSuccessState) {
          if (state.type == listTopProductType[indexSelected]) {
            setState(() {
              isLoaded = true;
              listWatch = state.listWatch;
            });
          }
        } else if (state is GetClassicProductErrorState) {}
      },
      child: Column(
        children: [
          HeaderNavigationBar(
              listTab: listTabTitle, onTabSelected: onTabSelected),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 386,
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (context, index) => SizedBox(
                  width: 22,
                ),
                itemCount: isLoaded ? listWatch.length : listMockWatch.length,
                itemBuilder: (context, index) {
                  return isLoaded
                      ? CardWatch(
                          watchData: listWatch[index],
                          onAdd: () => onClickAddWatch(listWatch[index]),
                          onClick: onCLickDetailWatch,
                        )
                      : CardFakeWatch();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  onTabSelected(int index) {
    if (index != indexSelected) {
      indexSelected = index;
      BlocProvider.of<ProductBloc>(context).add(GetClassicProductEvent(
          limit: 5, page: 1, type: listTopProductType[indexSelected]));
      listWatch = [];
      setState(() {});
    }
  }

  onClickAddWatch(Watch watch) {
    BlocProvider.of<ProductBloc>(context).add(UpdateProductToCartEvent(
        watchId: watch.id, quantity: 1, type: UpdateCartTypeEnum.PLUS));
  }

  onCLickDetailWatch(Watch watch) {
    BlocProvider.of<ProductBloc>(context)
        .add(GetDetailProductEvent(watchId: watch.id));
  }

  @override
  bool get wantKeepAlive => true;
}
