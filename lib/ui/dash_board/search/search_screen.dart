import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/product/product_event.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/card/card_recent_search.dart';
import 'package:flutter_mob/ui/components/card/card_watch.dart';
import 'package:flutter_mob/ui/components/input/search_input_field.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final List<String> listRecentSearchs = [
    "Eco-Drive Bracelet",
    "Zeitwerk Date",
    "Tourbillion Gold",
    "Chronograph Radio"
  ];
  List<Watch> listWatch = [];
  bool isFocusInput = false;
  bool isSearched = false;

  @override
  void initState() {
    focusNode.addListener(() {
      isFocusInput = focusNode.hasFocus;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SearchInputField(
                controller: controller,
                focusNode: focusNode,
                onSearch: (textSearch) {
                  listWatch = Constants.listMockDataWatch;
                  isSearched = true;
                  focusNode.unfocus();
                  setState(() {});
                },
              ),
            ),
            Expanded(
                child: Stack(
              children: [
                if (!isFocusInput && isSearched)
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              TextNormal(
                                title: listWatch.isNotEmpty
                                    ? StringName.searchResult
                                    : StringName.searchNotFound,
                                fontName: AppThemes.jaldi,
                                size: 22,
                                lineHeight: 1.2,
                                colors: AppColors.black1,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Wrap(
                                runSpacing: 30,
                                spacing: 20,
                                children: listWatch
                                    .map((e) => CardWatch(
                                          watchData: e,
                                          isShowAddButton: false,
                                          widthCard: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60) /
                                              2,
                                          heightCard: 260,
                                          onClick: onCLickDetailWatch,
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                if (isFocusInput)
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      children: listRecentSearchs
                          .map((e) => CardRecentSearch(
                                textSearch: e,
                                onClickTextSearch: (textSearch) {
                                  listWatch = Constants.listMockDataWatch;
                                  isSearched = true;
                                  focusNode.unfocus();
                                  setState(() {});
                                },
                              ))
                          .toList(),
                    ),
                  )
              ],
            ))
          ],
        ),
      ),
    );
  }

  onCLickDetailWatch(Watch watch) {
    BlocProvider.of<ProductBloc>(context)
        .add(GetDetailProductEvent(watchId: watch.id));
  }
}
