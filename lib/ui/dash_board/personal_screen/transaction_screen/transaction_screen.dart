import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/order/order_bloc.dart';
import 'package:flutter_mob/blocs/order/order_event.dart';
import 'package:flutter_mob/blocs/transaction_histories/transaction_histories_bloc.dart';
import 'package:flutter_mob/blocs/transaction_histories/transaction_histories_event.dart';
import 'package:flutter_mob/blocs/transaction_histories/transaction_histories_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/models/transaction/transaction.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/card/card_transaction.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Transaction> listTransaction = [];

  @override
  void initState() {
    BlocProvider.of<TransactionHistoriesBloc>(context)
        .add(GetListTransactionHistoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionHistoriesBloc, TransactionHistoriesState>(
      listener: (context, state) async {
        if (state is TransactionHistoriesLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is GetListTransactionHistoriesSuccessState) {
          LoadingHelper.hideLoading(context);
          setState(() {
            listTransaction = state.listTransactionHistories;
          });
        } else if (state is TransactionHistoriesErrorState) {
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
        body: SafeArea(
          child: Column(
            children: [
              AppBarTitle(
                  appTitle: StringName.transactionHistories,
                  fontName: AppThemes.jaldi,
                  fontSize: 20),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          if (listTransaction.isNotEmpty)
                            ...listTransaction
                                .map((e) => CardTransaction(transaction: e))
                                .toList(),
                          if (listTransaction.isEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 100),
                              child: TextNormal(
                                title: StringName.noTransaction,
                                colors: AppColors.bPrimaryColor,
                                fontName: AppThemes.spectral,
                                size: 18,
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
