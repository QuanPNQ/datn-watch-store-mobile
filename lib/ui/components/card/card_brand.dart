import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/models/brand/brand.dart';
import 'package:flutter_svg/svg.dart';

class CardBrand extends StatelessWidget {
  final Brand brand;
  final Function()? onClick;

  const CardBrand({super.key, required this.brand, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 113,
      height: 76,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.grey2.withOpacity(0.05)),
      child: brand.logo.contains("svg")
          ? SvgPicture.network(brand.logo)
          : Image.network(brand.logo),
    );
  }
}
