import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchInputField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String textSearch)? onSearch;
  final FocusNode? focusNode;

  const SearchInputField(
      {super.key, required this.controller, this.onSearch, this.focusNode});

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        focusNode: widget.focusNode,
        textDirection: TextDirection.ltr,
        keyboardType: TextInputType.text,
        controller: widget.controller,
        autofocus: false,
        onFieldSubmitted: (newValue) {
          if (widget.onSearch != null && newValue.isNotEmpty) {
            widget.onSearch!(newValue);
          }
        },
        cursorColor: AppColors.grey2.withOpacity(0.5),
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) {
          setState(() {});
        },
        style: TextStyle(
            fontFamily: AppThemes.jaldi,
            color: AppColors.bPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1,
            letterSpacing: 0.5),
        decoration: InputDecoration(
            hintTextDirection: TextDirection.ltr,
            hintText: StringName.search,
            errorStyle: TextStyle(
                fontSize: 14,
                color: AppColors.pink,
                fontFamily: AppThemes.jaldi,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5.r),
            filled: true,
            fillColor: AppColors.grey1.withOpacity(0.3),
            contentPadding: EdgeInsets.only(top: 10, bottom: 10),
            hintStyle: TextStyle(
                color: AppColors.bPrimaryColor.withOpacity(0.3),
                fontSize: 14,
                fontFamily: AppThemes.jaldi,
                height: 1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  20,
                )),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.pink),
                borderRadius: BorderRadius.circular(
                  20,
                )),
            suffixIcon: widget.controller.text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      widget.controller.clear();
                    },
                    child: Icon(Icons.close, color: AppColors.bPrimaryColor))
                : null,
            prefixIcon: GestureDetector(
              onTap: () {
                if (widget.controller.text.isEmpty && widget.onSearch == null)
                  return;
                widget.onSearch!(widget.controller.text);
              },
              child: Icon(
                Icons.search,
                color: widget.controller.text.isNotEmpty
                    ? AppColors.bPrimaryColor
                    : AppColors.grey2.withOpacity(0.5),
              ),
            )),
      ),
    );
  }
}
