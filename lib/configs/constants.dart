import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:meta/meta.dart';

@immutable
class Constants {
  /* Routing Names */
  static const String splashScreen = '/splash';
  static const String onBoardingScreen = '/on-boarding';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String dashBoardScreen = '/dash_board-screen';

  static const String baseUrl = 'https://portal.kamcpap.com/api/';

  static const List<WalkThrough> listWalkThroughDefault = [
    WalkThrough(
        title: "Cửa hàng đồng hồ nam cao cấp",
        content:
            "Uy tín chất lượng tạo nên thương hiệu của\nchúng tôi rất vui được đồng hành cùng các bạn",
        imagePath: AppImages.imgWalkThrough1),
    WalkThrough(
        title: "Đồng hồ cổ điển",
        content:
            "Phong cách lịch lãm, vượt thời gian. Hãy để\nnhững chiếc đồng hồ cổ điển tôn vinh sự quý phái của bạn",
        imagePath: AppImages.imgWalkThrough2),
    WalkThrough(
        title: "Dịch vụ hậu mãi",
        content:
            "Bảo hành dài hạn, chăm sóc tận tình. Chúng\ntôi luôn đồng hành cùng bạn sau khi mua hàng",
        imagePath: AppImages.imgWalkThrough3)
  ];

  static const Map<String, String> authRequestHeaders = {
    'Content-type': 'application/json',
    'Accept': '*/*',
  };

  static const Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<Map<String, String>> requestHeadersToken() async {
    var token = SharedPrefManager().getString(SharedPrefManager.tokenKey);
    Map<String, String> _requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': token!
    };
    return _requestHeaders;
  }
}

/* define String Names */
class StringName {
  static String logout = 'Log out';
  static String watchShop = 'WATCH SHOP';
  static String skip = 'Bỏ qua';
  static String next = 'Tiếp';
  static String getStarted = 'Bắt đầu';
}
