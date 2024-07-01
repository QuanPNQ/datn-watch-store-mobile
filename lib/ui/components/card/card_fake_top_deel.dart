import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';

class CardFakeTopDeel extends StatelessWidget {
  const CardFakeTopDeel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 139,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.grey2.withOpacity(0.05)),
        ),
      ],
    );
  }
}
