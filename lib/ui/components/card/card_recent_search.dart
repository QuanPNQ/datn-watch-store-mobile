import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class CardRecentSearch extends StatelessWidget {
  final String textSearch;
  final Function(String textSearch) onClickTextSearch;

  const CardRecentSearch(
      {super.key, required this.textSearch, required this.onClickTextSearch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClickTextSearch(textSearch),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 32,
            ),
            SizedBox(
              width: 18,
            ),
            Expanded(
              child: TextNormal(
                title: textSearch,
                maxLine: 1,
                colors: AppColors.black1,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
