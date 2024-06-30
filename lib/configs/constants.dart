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
  static const String orderScreen = '/order-screen';

  static const String baseUrl =
      'https://watch-store-f8131ab05f69.herokuapp.com/api/';

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

  static const List<String> listTabOrders = [
    "Chờ xác nhận",
    "Chờ giao hàng",
    "Đã giao",
    "Đã huỷ",
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

  static String getStatusOrder(OrderStatusType status) {
    switch (status) {
      case OrderStatusType.PENDING:
        return "Chờ xác nhận";
      case OrderStatusType.PROCESSING:
        return "Chờ giao hàng";
      case OrderStatusType.DELIVERED:
        return "Đã giao";
      case OrderStatusType.CANCELLED:
        return "Đã huỷ";
    }
  }

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
  static const String logout = 'Đăng xuất';
  static const String watchShop = 'WATCH SHOP';
  static const String skip = 'Bỏ qua';
  static const String next = 'Tiếp';
  static const String getStarted = 'Bắt đầu';
  static const String login = 'Đăng Nhập';
  static const String login1 = 'Đăng nhập';
  static const String account = 'Tài khoản';
  static const String fillYourAccount = 'Nhập tài khoản của bạn';
  static const String password = 'Mật khẩu';
  static const String fillYourPassword = 'Nhập mật khẩu của bạn';
  static const String forgotPassword = 'Quên mật khẩu?';
  static const String notHaveAccount = 'Bạn chưa có tài khoản?';
  static const String signUp = 'Đăng ký';
  static const String email = 'Email';
  static const String phone = 'Phone';
  static const String hadAccount = 'Bạn đã có tài khoản?';
  static const String fillYourEmail = 'Nhập email của bạn';
  static const String fillYourPhone = 'Nhập số điện thoại của bạn';
  static const String hello = 'Xin chào!';
  static const String pickWatchThatYouWant =
      'Hãy chọn chiếc đồng hồ mà bạn muốn';
  static const String outstandingWatch = 'Sản phẩm nổi bật';
  static const String all = 'Tất cả';
  static const String searchBrand = 'Tìm kiếm thương hiệu';
  static const String topDeels = 'Giao dịch hàng đầu';
  static const String search = 'Tìm kiếm';
  static const String searchResult = 'Kết quả tìm kiếm';
  static const String searchNotFound = 'Không thấy kết quả';
  static const String addToCart = 'Thêm vào giỏ hàng';
  static const String comment = 'Bình luận:';
  static const String noComment = 'Chưa có bình luận';
  static const String cart = 'Giỏ hàng';
  static const String subtotal = 'Tổng tiền';
  static const String transport = 'Vận chuyển';
  static const String voucher = 'Mã khuyến mãi';
  static const String free = 'Free';
  static const String total = 'Thành tiền';
  static const String payment = 'Thanh toán';
  static const String notAddProducts = 'Chưa thêm sản phẩm';
  static const String orderInformation = 'Thông tin đơn hàng';
  static const String deliveryAddress = 'Địa chỉ nhận hàng';
  static const String paymentMethod = 'Phương thức thanh toán';
  static const String paymentOnDelivery = 'Thanh toán khi nhận hàng';
  static const String codeOrders = 'Mã đơn hàng';
  static const String orderDate = 'Thời gian đặt hàng';
  static const String estimatedDeliveryTime = 'Thời gian giao hàng dự kiến';
  static const String confirmOrder = 'Xác nhận đơn hàng';
  static const String accountInfo = 'Thông tin tài khoản';
  static const String notification = 'Thông báo';
  static const String order = 'Đơn hàng';
  static const String supportCenter = 'Trung tâm trợ giúp';
  static const String personalInformation = 'Thông tin cá nhân';
  static const String changePassword = 'Đổi mật khẩu';
  static const String update = 'Cập nhật';
  static const String inputOldPassword = 'Nhập mật khẩu cũ';
  static const String inputNewPassword = 'Nhập mật khẩu mới';
  static const String inputConfirmNewPassword = 'Xác nhận lại mật khẩu';
  static const String change = 'Thay đổi';
  static const String listOrder = 'Đơn hàng';
  static const String viewDetail = 'Xem chi tiết';
  static const String totalPayment = 'Tổng Thanh Toán:';
  static const String codeOrder = 'Mã đơn hàng';
  static const String confirm = 'Xác nhận';
  static const String cancel = 'Huỷ';
  static const String loginError = 'Lỗi đăng nhập';
  static const String signupError = 'Lỗi đăng ký';
  static const String notAllowEmpty = 'Không được để trống!';
  static const String emailNotValid = 'Email không hợp lệ!';
  static const String signupSuccess = 'Đăng ký thành công';
  static const String loginNow = 'Bạn có muốn đăng nhập ngay?';
}

/* define String Names */
class DateFormat {
  static const String dateHour = 'dd-MM-yyyy HH:mm';
  static const String date = 'dd-MM-yyyy';
}

class Regex {
  static const email = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
}

enum DiscountType { PERCENT, PERMANENT }

enum PaymentMethodType { CASH, VN_PAY }

enum OrderStatusType { PENDING, PROCESSING, DELIVERED, CANCELLED }

enum NotificationType { PROMOTION, EVENT, UPDATE }
