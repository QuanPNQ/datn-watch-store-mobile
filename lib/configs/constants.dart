import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/models/account/user.dart';
import 'package:flutter_mob/models/brand/brand.dart';
import 'package:flutter_mob/models/cart/cart_item.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_mob/models/notify/notification.dart' as model;

@immutable
class Constants {
  /* Routing Names */
  static const String splashScreen = '/splash';
  static const String onBoardingScreen = '/on-boarding';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String dashBoardScreen = '/dashboard-screen';
  static const String forgotPasswordScreen = '/forgot-password-screen';
  static const String watchDetailScreen = '/watch-detail-screen';
  static const String detailOrderScreen = '/detail-order-screen';
  static const String profileScreen = '/profile-screen';
  static const String changePasswordScreen = '/change-password-screen';
  static const String notifyScreen = '/notify-screen';

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

  static const List<String> listTabClassifyWatch = [
    "Bán chạy",
    "Phổ biến",
    "Mới",
    "Bộ sưu tập"
  ];

  static List<Watch> listMockDataWatch = [
    Watch(
      id: '1',
      brandId: '1',
      name: 'Luch CH 15',
      description:
          'Đồng hồ Luch 15, một trong những thương hiệu nổi đình nổi đám và cũng là một trong những cái tên phổ biến, có sức ảnh hưởng trong giới sản xuất đồng hồ đeo tay. Với những sản phẩm chất lượng,Luch 15 ngày càng khẳng định được vị thế cũng như chỗ đứng của mình.',
      size: 24,
      createdDate: DateTime(2024, 1, 14),
      photoUrls: [
        "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/design-dc011e6b-a663-4665-a203-82df9febaf43%201.png?alt=media&token=f590cfef-19bb-4893-b541-fcc63861eb53"
      ],
      price: 3000,
      quantity: 50,
    ),
    Watch(
      id: '1',
      brandId: '1',
      name: 'Luch CH 15',
      description:
          'Đồng hồ Luch 15, một trong những thương hiệu nổi đình nổi đám và cũng là một trong những cái tên phổ biến, có sức ảnh hưởng trong giới sản xuất đồng hồ đeo tay. Với những sản phẩm chất lượng,Luch 15 ngày càng khẳng định được vị thế cũng như chỗ đứng của mình.',
      size: 24,
      createdDate: DateTime(2024, 1, 14),
      photoUrls: [
        "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/design-dc011e6b-a663-4665-a203-82df9febaf43%201.png?alt=media&token=f590cfef-19bb-4893-b541-fcc63861eb53"
      ],
      price: 3000,
      quantity: 50,
    ),
    Watch(
      id: '1',
      brandId: '1',
      name: 'Luch CH 15',
      description:
          'Đồng hồ Luch 15, một trong những thương hiệu nổi đình nổi đám và cũng là một trong những cái tên phổ biến, có sức ảnh hưởng trong giới sản xuất đồng hồ đeo tay. Với những sản phẩm chất lượng,Luch 15 ngày càng khẳng định được vị thế cũng như chỗ đứng của mình.',
      size: 24,
      createdDate: DateTime(2024, 1, 14),
      photoUrls: [
        "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/design-dc011e6b-a663-4665-a203-82df9febaf43%201.png?alt=media&token=f590cfef-19bb-4893-b541-fcc63861eb53"
      ],
      price: 3000,
      quantity: 50,
    ),
    Watch(
      id: '1',
      brandId: '1',
      name: 'Luch CH 15',
      description:
          'Đồng hồ Luch 15, một trong những thương hiệu nổi đình nổi đám và cũng là một trong những cái tên phổ biến, có sức ảnh hưởng trong giới sản xuất đồng hồ đeo tay. Với những sản phẩm chất lượng,Luch 15 ngày càng khẳng định được vị thế cũng như chỗ đứng của mình.',
      size: 24,
      createdDate: DateTime(2024, 1, 14),
      photoUrls: [
        "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/design-dc011e6b-a663-4665-a203-82df9febaf43%201.png?alt=media&token=f590cfef-19bb-4893-b541-fcc63861eb53"
      ],
      price: 3000,
      quantity: 50,
    )
  ];

  static Watch mockDataWatch = Watch(
    id: '1',
    brandId: '1',
    name: 'Luch CH 15',
    description:
        'Đồng hồ Luch 15, một trong những thương hiệu nổi đình nổi đám và cũng là một trong những cái tên phổ biến, có sức ảnh hưởng trong giới sản xuất đồng hồ đeo tay. Với những sản phẩm chất lượng,Luch 15 ngày càng khẳng định được vị thế cũng như chỗ đứng của mình.',
    size: 24,
    createdDate: DateTime(2024, 1, 14),
    photoUrls: [
      "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/design-dc011e6b-a663-4665-a203-82df9febaf43%201.png?alt=media&token=f590cfef-19bb-4893-b541-fcc63861eb53"
    ],
    price: 3000,
    quantity: 50,
  );

  static List<Watch> listMockTopDeels = [
    Watch(
      id: '1',
      brandId: '1',
      name: 'Unisex Casio Vintage',
      description:
          'Đồng hồ Luch 15, một trong những thương hiệu nổi đình nổi đám và cũng là một trong những cái tên phổ biến, có sức ảnh hưởng trong giới sản xuất đồng hồ đeo tay. Với những sản phẩm chất lượng,Luch 15 ngày càng khẳng định được vị thế cũng như chỗ đứng của mình.',
      size: 24,
      createdDate: DateTime(2024, 1, 14),
      photoUrls: [
        "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/thumb_1542595515%201.png?alt=media&token=2fb13746-c7c0-472e-9a83-b313796430e7"
      ],
      price: 8690,
      quantity: 50,
    ),
    Watch(
      id: '1',
      brandId: '1',
      name: 'Unisex Casio Vintage',
      description:
          'Đồng hồ Luch 15, một trong những thương hiệu nổi đình nổi đám và cũng là một trong những cái tên phổ biến, có sức ảnh hưởng trong giới sản xuất đồng hồ đeo tay. Với những sản phẩm chất lượng,Luch 15 ngày càng khẳng định được vị thế cũng như chỗ đứng của mình.',
      size: 24,
      createdDate: DateTime(2024, 1, 14),
      photoUrls: [
        "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/thumb_1542595515%201.png?alt=media&token=2fb13746-c7c0-472e-9a83-b313796430e7"
      ],
      price: 8690,
      quantity: 50,
    ),
    Watch(
      id: '1',
      brandId: '1',
      name: 'Unisex Casio Vintage',
      description:
          'Đồng hồ Luch 15, một trong những thương hiệu nổi đình nổi đám và cũng là một trong những cái tên phổ biến, có sức ảnh hưởng trong giới sản xuất đồng hồ đeo tay. Với những sản phẩm chất lượng,Luch 15 ngày càng khẳng định được vị thế cũng như chỗ đứng của mình.',
      size: 24,
      createdDate: DateTime(2024, 1, 14),
      photoUrls: [
        "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/thumb_1542595515%201.png?alt=media&token=2fb13746-c7c0-472e-9a83-b313796430e7"
      ],
      price: 8690,
      quantity: 50,
    ),
  ];

  static List<Brand> listMockBrands = [
    Brand(
        id: "1",
        name: "Rolex",
        description: "",
        logo:
            "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/Group%20224.svg?alt=media&token=0bc0b736-5f37-409a-9532-85218f67d2f8"),
    Brand(
        id: "2",
        name: "Patek philippe",
        description: "",
        logo:
            "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/Union.svg?alt=media&token=e80e3d89-7024-468a-b2cf-23940eeea085"),
    Brand(
        id: "3",
        name: "Audemars",
        description: "",
        logo:
            "https://firebasestorage.googleapis.com/v0/b/apolis-301dc.appspot.com/o/Union%20(1).svg?alt=media&token=131828f5-a386-4170-987f-c73694e810a0")
  ];

  static List<Comment> listMockDataComment = [
    Comment(
      user: User(
        id: "1",
        name: "Văn Sang",
        avatarUrl:
            "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YXZhdGFyfGVufDB8fDB8fHww",
      ),
      content: "Đồng hồ đẳng cấp xứng đáng để sở hữu",
    ),
    Comment(
      user: User(
        id: "2",
        name: "Phương Ngọc Quân",
        avatarUrl:
            "https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fG1hbiUyMGF2YXRhcnxlbnwwfHwwfHx8MA%3D%3D",
      ),
      content: "Đồng hồ thực sự đẳng cấp xứng đáng để sở hữu đóng gói cẩn thận",
    ),
  ];

  static List<CartItem> listMockCarts = [
    CartItem(id: "1", watch: mockDataWatch, quantity: 1),
    CartItem(id: "2", watch: mockDataWatch, quantity: 1),
    CartItem(id: "3", watch: mockDataWatch, quantity: 1),
  ];

  static List<OrderItem> listMockOrderItems = [
    OrderItem(id: "1", watch: mockDataWatch, quantity: 1),
    OrderItem(id: "2", watch: mockDataWatch, quantity: 1),
    OrderItem(id: "3", watch: mockDataWatch, quantity: 1),
  ];

  static Order mockDataOrder = Order(
      id: "1",
      codeOrder: "WS001",
      listWatch: listMockOrderItems,
      status: OrderStatusType.PENDING,
      orderDate: DateTime.now());

  static ShippingAddress mockDataShippingAddress = ShippingAddress(
      id: '1',
      title: 'Địa chỉ nhà',
      receiver: 'Hoàng Văn Sang',
      address: 'Số 30, ngõ 93, Vũ Hữu, Thanh Xuân, Bắc Thanh Xuân, Hà Nội',
      isDefault: true,
      phoneNumber: '(+84)968786843');

  static Account mockDataAccount = Account(
      id: "1",
      userName: "quanNQ",
      email: "quan.pn29@gmail.com",
      phoneNumber: "0911237889",
      name: "Phương Ngọc Quân",
      avatarUrl:
          "https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fG1hbiUyMGF2YXRhcnxlbnwwfHwwfHx8MA%3D%3D");

  static List<model.Notification> mockListNotification = [
    model.Notification(
      id: "1",
      title: "Hot sale",
      message:
          "Đồng hồ nam Orient giảm giá sâu cho các quý ông vào dịp hè này.",
      createdAt: DateTime.now(),
      isRead: false,
      type: NotificationType.EVENT.name,
    ),
    model.Notification(
      id: "2",
      title: "Tin tức",
      message: "Seiko vừa cho ra mắt sản phảm mới.",
      createdAt: DateTime.now(),
      isRead: false,
      type: NotificationType.EVENT.name,
    ),
    model.Notification(
      id: "3",
      title: "Khuyến mãi",
      message: "Giảm giá lên đếm 30% dành cho các đồng hồ cơ từ 5 triệu đồng.",
      createdAt: DateTime.now(),
      isRead: false,
      type: NotificationType.EVENT.name,
    ),
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
  static String logout = 'Đăng xuất';
  static String watchShop = 'WATCH SHOP';
  static String skip = 'Bỏ qua';
  static String next = 'Tiếp';
  static String getStarted = 'Bắt đầu';
  static String login = 'Đăng Nhập';
  static String login1 = 'Đăng nhập';
  static String account = 'Tài khoản';
  static String fillYourAccount = 'Nhập tài khoản của bạn';
  static String password = 'Mật khẩu';
  static String fillYourPassword = 'Nhập mật khẩu của bạn';
  static String forgotPassword = 'Quên mật khẩu?';
  static String notHaveAccount = 'Bạn chưa có tài khoản?';
  static String signUp = 'Đăng ký';
  static String email = 'Email';
  static String phone = 'Phone';
  static String hadAccount = 'Bạn đã có tài khoản?';
  static String fillYourEmail = 'Nhập email của bạn';
  static String fillYourPhone = 'Nhập số điện thoại của bạn';
  static String hello = 'Xin chào!';
  static String pickWatchThatYouWant = 'Hãy chọn chiếc đồng hồ mà bạn muốn';
  static String outstandingWatch = 'Sản phẩm nổi bật';
  static String all = 'Tất cả';
  static String searchBrand = 'Tìm kiếm thương hiệu';
  static String topDeels = 'Giao dịch hàng đầu';
  static String search = 'Tìm kiếm';
  static String searchResult = 'Kết quả tìm kiếm';
  static String searchNotFound = 'Không thấy kết quả';
  static String addToCart = 'Thêm vào giỏ hàng';
  static String comment = 'Bình luận:';
  static String noComment = 'Chưa có bình luận';
  static String cart = 'Giỏ hàng';
  static String subtotal = 'Tổng tiền';
  static String transport = 'Vận chuyển';
  static String voucher = 'Mã khuyến mãi';
  static String free = 'Free';
  static String total = 'Thành tiền';
  static String payment = 'Thanh toán';
  static String notAddProducts = 'Chưa thêm sản phẩm';
  static String orderInformation = 'Thông tin đơn hàng';
  static String deliveryAddress = 'Địa chỉ nhận hàng';
  static String paymentMethod = 'Phương thức thanh toán';
  static String paymentOnDelivery = 'Thanh toán khi nhận hàng';
  static String codeOrders = 'Mã đơn hàng';
  static String orderDate = 'Thời gian đặt hàng';
  static String estimatedDeliveryTime = 'Thời gian giao hàng dự kiến';
  static String confirmOrder = 'Xác nhận đơn hàng';
  static String accountInfo = 'Thông tin tài khoản';
  static String notification = 'Thông báo';
  static String order = 'Đơn hàng';
  static String supportCenter = 'Trung tâm trợ giúp';
  static String personalInformation = 'Thông tin cá nhân';
  static String changePassword = 'Đổi mật khẩu';
  static String update = 'Cập nhật';
  static String inputOldPassword = 'Nhập mật khẩu cũ';
  static String inputNewPassword = 'Nhập mật khẩu mới';
  static String inputConfirmNewPassword = 'Xác nhận lại mật khẩu';
  static String change = 'Thay đổi';
}

/* define String Names */
class DateFormat {
  static String dateHour = 'dd-MM-yyyy HH:mm';
  static String date = 'dd-MM-yyyy';
}

enum DiscountType { PERCENT, PERMANENT }

enum PaymentMethodType { CASH, VN_PAY }

enum OrderStatusType { PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED }

enum NotificationType { PROMOTION, EVENT, UPDATE }
