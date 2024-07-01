import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/brand/brand_bloc.dart';
import 'package:flutter_mob/blocs/brand/brand_event.dart';
import 'package:flutter_mob/blocs/brand/brand_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/brand/brand.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/card/card_brand.dart';
import 'package:flutter_mob/ui/components/card/card_fake_brand.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';

class AllBrandScreen extends StatefulWidget {
  const AllBrandScreen({super.key});

  @override
  State<AllBrandScreen> createState() => _AllBrandScreenState();
}

class _AllBrandScreenState extends State<AllBrandScreen> {
  bool isLoaded = false;
  List<Brand> listBrand = [];
  List<Brand> listMockBrand = Constants.listMockBrands +
      Constants.listMockBrands +
      Constants.listMockBrands +
      Constants.listMockBrands;

  @override
  void initState() {
    BlocProvider.of<BrandBloc>(context)
        .add(GetListBrandEvent(limit: 50, page: 1, isViewAll: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthCard = (MediaQuery.of(context).size.width - 40 - 20) / 2;
    return BlocListener<BrandBloc, BrandState>(
      listener: (context, state) async {
        if (state is BrandLoadingState) {
          if (!state.isViewAll) return;

          setState(() {
            isLoaded = false;
          });
        } else if (state is GetBrandSuccessState) {
          if (!state.isViewAll) return;

          setState(() {
            isLoaded = true;
            listBrand = state.listBrand;
          });
        } else if (state is BrandErrorState) {
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
              AppBarTitle(appTitle: StringName.searchBrand),
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
                              ? listBrand
                                  .map((e) => CardBrand(
                                        width: widthCard,
                                        height: widthCard * 76 / 113,
                                        brand: e,
                                        onClick: () {
                                          handleClickBrand(e);
                                        },
                                      ))
                                  .toList()
                              : listMockBrand
                                  .map((e) => CardFakeBrand(
                                        width: widthCard,
                                        height: widthCard * 76 / 113,
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

  handleClickBrand(Brand brand) {
    Navigator.pushNamed(context, Constants.watchByBrandScreen,
        arguments: brand);
  }
}
