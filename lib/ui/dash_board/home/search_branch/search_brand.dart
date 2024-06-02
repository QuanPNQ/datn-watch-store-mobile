import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/brand/brand.dart';
import 'package:flutter_mob/ui/components/card/card_brand.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class SearchBrand extends StatefulWidget {
  const SearchBrand({super.key});

  @override
  State<SearchBrand> createState() => _SearchBrandState();
}

class _SearchBrandState extends State<SearchBrand> {
  List<Brand> listBrand = Constants.listMockBrands;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              TextNormal(
                title: StringName.all,
                size: 14,
                lineHeight: 1.5,
                colors: AppColors.blue300,
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
              itemCount: listBrand.length,
              itemBuilder: (context, index) {
                return CardBrand(
                  brand: listBrand[index],
                  onClick: handleClickBrand(listBrand[index]),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  handleClickBrand(Brand brand) {}
}
