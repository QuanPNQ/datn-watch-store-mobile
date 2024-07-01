import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';

class CardFakeWatch extends StatelessWidget {
  final bool isShowAddButton;
  final double widthCard;
  final double heightCard;

  const CardFakeWatch(
      {super.key,
      this.widthCard = 187,
      this.heightCard = 386,
      this.isShowAddButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightCard,
      width: widthCard,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: heightCard,
            width: widthCard,
            decoration: BoxDecoration(
                color: AppColors.grey2.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.only(bottom: isShowAddButton ? 20 : 0),
          ),
          Column(
            children: [
              const Spacer(),
              if (isShowAddButton)
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor, shape: BoxShape.circle),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.grey2.withOpacity(0.05),
                        shape: BoxShape.circle),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
