import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/product/product_event.dart';
import 'package:flutter_mob/blocs/product/product_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_mob/ui/components/card/card_recent_search.dart';
import 'package:flutter_mob/ui/components/card/card_watch.dart';
import 'package:flutter_mob/ui/components/input/search_input_field.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  List<String> listRecentSearchs = [];
  List<Watch> listWatch = [];
  bool isFocusInput = false;
  bool isSearched = false;

  @override
  void initState() {
    focusNode.addListener(() {
      isFocusInput = focusNode.hasFocus;
      setState(() {});
    });
    initData();
    super.initState();
  }

  initData() async {
    SharedPrefManager? sharedPrefManager =
        await SharedPrefManager.getInstance();
    listRecentSearchs = await sharedPrefManager!
            .getStringList(SharedPrefManager.searchHistoriesKey) ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) async {
        if (state is GetListProductLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is GetListProductSuccessState) {
          LoadingHelper.hideLoading(context);
          setState(() {
            listWatch = state.listWatch;
          });
        } else if (state is GetListProductErrorState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: Scaffold(
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
                  onSearch: (textSearch) async {
                    BlocProvider.of<ProductBloc>(context).add(
                        GetListProductEvent(
                            limit: 50, page: 1, textSearch: textSearch));
                    isSearched = true;
                    focusNode.unfocus();
                    setState(() {});
                    if (textSearch.isNotEmpty) {
                      int existed = listRecentSearchs
                          .indexWhere((element) => element == textSearch);
                      if (existed < 0) {
                        listRecentSearchs.add(textSearch);
                        SharedPrefManager? sharedPrefManager =
                            await SharedPrefManager.getInstance();
                        await sharedPrefManager!.putStringList(
                            SharedPrefManager.searchHistoriesKey,
                            listRecentSearchs);
                      }
                    }
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
                        children: getLastFiveOrAll(listRecentSearchs)
                            .reversed
                            .map((e) => CardRecentSearch(
                                  textSearch: e,
                                  onClickTextSearch: (textSearch) async {
                                    if (textSearch.isNotEmpty) {
                                      controller.text = textSearch;
                                      isSearched = true;
                                      focusNode.unfocus();
                                      BlocProvider.of<ProductBloc>(context).add(
                                          GetListProductEvent(
                                              limit: 50,
                                              page: 1,
                                              textSearch: textSearch));
                                      setState(() {});
                                    }
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
      ),
    );
  }

  onCLickDetailWatch(Watch watch) {
    BlocProvider.of<ProductBloc>(context)
        .add(GetDetailProductEvent(watchId: watch.id));
  }

  List<String> getLastFiveOrAll(List<String> inputList) {
    if (inputList.length <= 5) {
      return inputList;
    } else {
      return inputList.sublist(inputList.length - 5);
    }
  }
}
