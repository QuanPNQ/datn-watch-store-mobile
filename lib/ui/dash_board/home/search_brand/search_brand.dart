import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/brand/brand_bloc.dart';
import 'package:flutter_mob/blocs/brand/brand_event.dart';
import 'package:flutter_mob/blocs/brand/brand_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/brand/brand.dart';
import 'package:flutter_mob/ui/components/card/card_brand.dart';
import 'package:flutter_mob/ui/components/card/card_fake_brand.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class SearchBrand extends StatefulWidget {
  const SearchBrand({super.key});

  @override
  State<SearchBrand> createState() => _SearchBrandState();
}

class _SearchBrandState extends State<SearchBrand>
    with AutomaticKeepAliveClientMixin {
  List<Brand> listBrand = [];
  List<Brand> listMockBrand = Constants.listMockBrands;
  bool isLoaded = false;

  @override
  void initState() {
    BlocProvider.of<BrandBloc>(context)
        .add(GetListBrandEvent(limit: 5, page: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BrandBloc, BrandState>(
      listener: (context, state) async {
        if (state is BrandLoadingState) {
          if (state.isViewAll) return;

          setState(() {
            isLoaded = false;
          });
        } else if (state is GetBrandSuccessState) {
          if (state.isViewAll) return;

          setState(() {
            isLoaded = true;
            listBrand = state.listBrand;
          });
        } else if (state is BrandErrorState) {}
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
                  title: StringName.searchBrand,
                  fontName: AppThemes.dmSerifDisplay,
                  size: 20,
                  lineHeight: 1.2,
                  colors: AppColors.black1,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Constants.allBrandScreen);
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
            height: 21,
          ),
          SizedBox(
            height: 76,
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (context, index) => SizedBox(
                  width: 20,
                ),
                itemCount: isLoaded ? listBrand.length : listMockBrand.length,
                itemBuilder: (context, index) {
                  return isLoaded
                      ? CardBrand(
                          brand: listBrand[index],
                          onClick: () {
                            handleClickBrand(listBrand[index]);
                          },
                        )
                      : CardFakeBrand();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  handleClickBrand(Brand brand) {
    Navigator.pushNamed(context, Constants.watchByBrandScreen,
        arguments: brand);
  }

  @override
  bool get wantKeepAlive => true;
}
