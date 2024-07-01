import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/models/brand/brand.dart';
import 'package:flutter_svg/svg.dart';

class CardBrand extends StatelessWidget {
  final double? height;
  final double? width;
  final Brand brand;
  final Function()? onClick;

  const CardBrand(
      {super.key, required this.brand, this.onClick, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: width ?? 113,
        height: height ?? 76,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.grey2.withOpacity(0.05)),
        child: brand.logo.contains("svg")
            ? SvgPicture.network(brand.logo)
            : Image.network(brand.logo),
      ),
    );
  }
}
