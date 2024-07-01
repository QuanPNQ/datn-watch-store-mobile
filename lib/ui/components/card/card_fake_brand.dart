import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/configs/colors.dart';

class CardFakeBrand extends StatelessWidget {
  final double? height;
  final double? width;

  const CardFakeBrand({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 113,
      height: height ?? 76,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.grey2.withOpacity(0.05)),
    );
  }
}
