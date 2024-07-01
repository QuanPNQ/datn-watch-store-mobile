import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/configs/colors.dart';

class CardFakeBrand extends StatelessWidget {
  const CardFakeBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 113,
      height: 76,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.grey2.withOpacity(0.05)),
    );
  }
}
