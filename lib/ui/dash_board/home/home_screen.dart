// import 'package:flutter/material.dart';
// import 'package:flutter_mob/configs/colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_mob/configs/constants.dart';
// import 'package:flutter_mob/configs/images.dart';
// import 'package:flutter_mob/ui/components/icon_button_notify.dart';
// import 'package:flutter_mob/ui/components/text_bold.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String _name = "Wayne";
//   bool _isShowing = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: Container(
//           margin: EdgeInsets.only(left: 4.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Welcome",
//                   style: TextStyle(
//                     color: AppColors.grey400,
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w400,
//                     fontStyle: FontStyle.normal,
//                     letterSpacing: 0.5,
//                     fontFamily: 'ProximaNovaA',
//                     height: 1.5.h,
//                   )),
//               TextBold(
//                   title: _name,
//                   size: 24.sp,
//                   colors: AppColors.kPrimaryColor,
//                   maxLine: 1),
//             ],
//           ),
//         ),
//         toolbarHeight: 89.h,
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         centerTitle: false,
//         automaticallyImplyLeading: false,
//       ),
//       backgroundColor: AppColors.primaryColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 8.h),
//                 _isShowing == true
//                     ? Container(
//                         constraints: BoxConstraints(
//                           minHeight: 143.h
//                         ),
//                         padding: EdgeInsets.symmetric(vertical: 16.w,horizontal: 16.w) ,
//                         decoration: BoxDecoration(
//                             color: AppColors.hPrimaryColor,
//                             borderRadius: BorderRadius.circular(12.r)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   child: TextBold(
//                                       title: "Welcome to Kälm",
//                                       size: 24,
//                                       colors: AppColors.kPrimaryColor,
//                                       maxLine: 2),
//                                 ),
//                                 Container(
//                                   height: 40.h,
//                                   width: 40.w,
//                                   child: IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         _isShowing = false;
//                                       });
//                                     },
//                                     icon: Image.asset(
//                                       AppImages.iconCancel,
//                                       height: 12.h,
//                                       width: 12.w,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(right: 34.w),
//                               child: Text(
//                                 "Here’s where you’ll be able to view your sleep run service from the previous night.",
//                                 style: TextStyle(
//                                   color: AppColors.kPrimaryColor,
//                                   fontSize: 12.sp,
//                                   letterSpacing: 0.5,
//                                   fontWeight: FontWeight.w400,
//                                   fontStyle: FontStyle.normal,
//                                   fontFamily: 'Proxima Nova Alt',
//                                   height: 1.2.h,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16.h,),
//                             Container(
//                               alignment: Alignment.topLeft,
//                               child: ElevatedButton(
//                                 style: ButtonStyle(
//                                   shape: MaterialStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(8.r),
//                                     ),
//                                   ),
//                                   backgroundColor: MaterialStateProperty.all(
//                                       AppColors.kPrimaryColor),
//                                 ),
//                                 child: Container(
//
//                                   child: Text(
//                                     "Learn More",
//                                     style: TextStyle(
//                                         color: AppColors.primaryColor,
//                                         fontWeight: FontWeight.w700,
//                                         fontStyle: FontStyle.normal,
//                                         fontFamily: 'Proxima Nova Alt',
//                                         fontSize: 12.sp,
//                                         height: 1.5.h,
//                                         letterSpacing: 0.5),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.pushNamed(
//                                       context, Constants.learnMoreScreen);
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : SizedBox(
//                         height: 0,
//                       ),
//                 _isShowing
//                     ? SizedBox(
//                         height: 26.h,
//                       )
//                     : SizedBox(
//                         height: 0,
//                       ),
//                 GestureDetector(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextBold(
//                           title: "Fit your Mask",
//                           size: 14,
//                           colors: AppColors.kPrimaryColor,
//                           maxLine: 1),
//                       SizedBox(
//                         height: 18.h,
//                       ),
//                       Container(
//                         height: 164.h,
//                         width: 327.w,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Color(0xff1b2430),
//                             image: DecorationImage(
//                                 image: AssetImage(
//                                   'assets/images/v2.png',
//                                 ),
//                                 fit: BoxFit.cover)),
//                         child: Container(
//                           alignment: Alignment.topLeft,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(
//                         context, Constants.maskCalibrationScreen);
//                   },
//                 ),
//                 SizedBox(
//                   height: 26.h,
//                 ),
//                 GestureDetector(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextBold(
//                           title: "Add Profile Data",
//                           size: 14.h,
//                           colors: AppColors.kPrimaryColor,
//                           maxLine: 1),
//                       SizedBox(
//                         height: 16.h,
//                       ),
//                       Container(
//                         width: 327.w,
//                         height: 135.h,
//                         // padding: EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: Color(0xff374151),
//                               width: 1,
//                             ),
//                             image: DecorationImage(
//                                 image: AssetImage('assets/images/v1.png'),
//                                 fit: BoxFit.cover)),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(
//                         context, Constants.addProfileDataScreen);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
