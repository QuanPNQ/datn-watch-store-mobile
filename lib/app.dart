import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mob/router/app_router.dart';
import 'package:flutter_mob/ui/splash/splash_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:fluttertoast/fluttertoast.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fCMSetup(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ScreenUtilInit(
        builder: (ctx, _) => GlobalLoaderOverlay(
          overlayColor: Colors.black26,
          overlayOpacity: 0.7,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringName.watchShop,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle.light),
              canvasColor: Colors.transparent,
            ),
            home: const SplashScreen(),
            onGenerateRoute: onGenerateRoute,
            builder: FToastBuilder(),
          ),
        ),
        designSize: const Size(375, 812),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
