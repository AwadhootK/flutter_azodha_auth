// import 'package:azo_auth/ui/widgets/custom_snackbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:logging/logging.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ErrorScreen extends StatefulWidget {
//   const ErrorScreen({super.key});
//   static const routeName = '/ErrorScreen';

//   @override
//   State<ErrorScreen> createState() => _ErrorScreenState();
// }

// class _ErrorScreenState extends State<ErrorScreen> {
//   String? encodeQueryParameters(Map<String, String> params) {
//     return params.entries
//         .map((MapEntry<String, String> e) =>
//             '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
//         .join('&');
//   }

//   final log = Logger('ErrorScreen');

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.fromLTRB(14.w, 0, 21.w, 0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 80.h),
//             Center(
//               child: Image.asset(
//                 'assets/Errorimage/ErrorScreen.png',
//                 width: 230.w,
//               ),
//             ),
//             SizedBox(
//               height: 30.h,
//             ),
//             SizedBox(
//               width: 309.w,
//               child: Text(
//                 "We are currently experiencing issues with our app",
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       fontSize: 24.sp,
//                     ),
//               ),
//             ),
//             SizedBox(height: 16.h),
//             SizedBox(
//               width: 357.w,
//               child: Text(
//                 "We are actively working to resolve this issue. In the meantime, if you have any urgent inquiries, please don't hesitate to reach out to us at",
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyText2!
//                     .copyWith(fontSize: 16.sp, height: 1.6),
//               ),
//             ),
//             SizedBox(height: 3.h),
//             SizedBox(
//               width: 357.w,
//               child: InkWell(
//                 onTap: () async {
//                   try {
//                     final Uri emailLaunchUri = Uri(
//                       scheme: 'mailto',
//                       path: Config.SUPPORT_EMAIL_TECH,
//                       query: encodeQueryParameters(<String, String>{
//                         'subject':
//                             'Support email for Participants in the Ripple mobile app',
//                       }),
//                     );
//                     var url = emailLaunchUri;
//                     if (!await launchUrl(
//                       emailLaunchUri,
//                     )) {
//                       throw 'Could not launch $url';
//                     }
//                   } catch (e) {
//                     ScaffoldMessenger.of(context)
//                         .showSnackBar(customSnackBar(content: e.toString()));
//                   }
//                 },
//                 child: Text(
//                   "rippleadmin@sheareshealthcare.com.sg",
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       fontSize: 16.sp, color: const Color(0xFF3D42ED)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30.h),
//             Text(
//               'We apologise for any inconvenience caused.',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText2!
//                   .copyWith(fontSize: 16.sp, height: 1.6),
//             ),
//             SizedBox(height: 60.h),
//           ],
//         ),
//       ),
//     );
//   }
// }
