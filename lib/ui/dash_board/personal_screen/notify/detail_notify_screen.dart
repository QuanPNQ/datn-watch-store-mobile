import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/notify/notify_bloc.dart';
import 'package:flutter_mob/blocs/notify/notify_event.dart';
import 'package:flutter_mob/blocs/notify/notify_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/models/notify/notification.dart' as model;
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:flutter_mob/utils/date_time_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailNotifyScreen extends StatefulWidget {
  final model.Notification notification;

  const DetailNotifyScreen({super.key, required this.notification});

  @override
  State<DetailNotifyScreen> createState() => _DetailNotifyScreenState();
}

class _DetailNotifyScreenState extends State<DetailNotifyScreen> {
  bool isSuccess = false;
  bool isLoading = true;

  @override
  void initState() {
    BlocProvider.of<NotifyBloc>(context)
        .add(ReadNotifyEvent(widget.notification.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotifyBloc, NotifyState>(
      listener: (context, state) async {
        if (state is NotifyLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is ReadNotifySuccessState) {
          BlocProvider.of<NotifyBloc>(context).add(GetListNotifyEvent());
          setState(() {
            isSuccess = true;
            isLoading = false;
          });
        } else if (state is ReadNotifyErrorState) {
          LoadingHelper.hideLoading(context);
          setState(() {
            isLoading = false;
          });
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
                  appTitle: StringName.detailNotification,
                  fontName: AppThemes.jaldi,
                  fontSize: 20),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      Column(
                        children: [
                          if (isSuccess)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextNormal(
                                  title: widget.notification.title,
                                  colors: AppColors.bPrimaryColor,
                                  fontName: AppThemes.specialElite,
                                  size: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextNormal(
                                  title: "Ngày: " +
                                      DateTimeHelper.formatDate(
                                          widget.notification.createdAt,
                                          format: DateFormat.date),
                                  colors: AppColors.bPrimaryColor,
                                  fontName: AppThemes.specialElite,
                                  size: 14,
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                TextNormal(
                                  title: widget.notification.message,
                                  colors: AppColors.bPrimaryColor,
                                  fontName: AppThemes.specialElite,
                                  size: 16,
                                ),
                              ],
                            ),
                          if (!isLoading && !isSuccess)
                            Container(
                              margin: EdgeInsets.only(top: 80),
                              child: TextNormal(
                                title: StringName.hasError,
                                colors: AppColors.bPrimaryColor,
                                fontName: AppThemes.spectral,
                                size: 18,
                              ),
                            )
                        ],
                      )
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
