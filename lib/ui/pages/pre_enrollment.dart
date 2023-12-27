// import 'package:azo_auth/ui/widgets/custom_snackbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PreEnrollScreen extends StatefulWidget {
//   const PreEnrollScreen({super.key});
//   static const routeName = '/PreEnrollScreen';
//   @override
//   State<PreEnrollScreen> createState() => _PreEnrollScreenState();
// }

// class _PreEnrollScreenState extends State<PreEnrollScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xfff8f8f8),
//         bottomNavigationBar: Container(
//           color: Colors.white,
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
//             child: ConstrainedBox(
//                 constraints:
//                     BoxConstraints.tightFor(width: 366.w, height: 62.h),
//                 child: Container()),
//           ),
//         ),
//         body: SingleChildScrollView(
//           physics: const NeverScrollableScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 39.h,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(25.w, 39.h, 0.w, 0.h),
//                     child: SizedBox(
//                         width: 144.w,
//                         height: 46.h,
//                         child:
//                             Image.asset('assets/landingimage/ripplelogo.png')),
//                   ),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(25.w, 0.h, 0.w, 0.h),
//                     child: SizedBox(
//                       width: 286.w,
//                       child: Text(
//                         "Looks like you're not in the programme yet!",
//                         style: GoogleFonts.notoSans(
//                             fontSize: 24.sp,
//                             fontWeight: FontWeight.w700,
//                             color: const Color(0xFF161616),
//                             wordSpacing: 2.0),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 62.h,
//                   ),
//                   Container(
//                     width: double.maxFinite,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.0.r)),
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(25.w, 30.h, 0, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 336.w,
//                             child: Text(
//                               "This app serves participants who have started their coaching journey with us.",
//                               style: GoogleFonts.notoSans(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: const Color(0xFF161616),
//                                   wordSpacing: 2.0),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           SizedBox(
//                             width: 336.w,
//                             child: Text(
//                               "Not to worry, your time is soon! You'll gain access to our app and all its great features once you're enrolled onto the programme.",
//                               style: GoogleFonts.notoSans(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: const Color(0xFF161616),
//                                   wordSpacing: 2.0),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           SizedBox(
//                               width: 336.w,
//                               child: RichText(
//                                 text: TextSpan(
//                                   text: 'Still need help?',
//                                   style: GoogleFonts.notoSans(
//                                       fontSize: 18.sp,
//                                       fontWeight: FontWeight.w400,
//                                       color: const Color(0xFF161616),
//                                       wordSpacing: 2.0),
//                                   children: <WidgetSpan>[
//                                     WidgetSpan(
//                                       child: InkWell(
//                                         onTap: () async {
//                                           try {
//                                             final Uri emailLaunchUri = Uri(
//                                               scheme: 'mailto',
//                                               path: Config.SUPPORT_EMAIL_TECH,
//                                               query:
//                                                   encodeQueryParameters(<String,
//                                                       String>{
//                                                 'subject':
//                                                     'Support email for Participants in the Ripple mobile app',
//                                               }),
//                                             );
//                                             var url = emailLaunchUri;
//                                             if (!await launchUrl(
//                                               emailLaunchUri,
//                                             )) {
//                                               throw 'Could not launch $url';
//                                             }
//                                           } catch (e) {
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(customSnackBar(
//                                                     content: e.toString()));
//                                           }
//                                         },
//                                         child: Text('Contact Us.',
//                                             style: GoogleFonts.notoSans(
//                                                 fontSize: 18.sp,
//                                                 fontWeight: FontWeight.w700,
//                                                 color: const Color(0xff3D42ED),
//                                                 wordSpacing: 2.0)),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                           SizedBox(
//                             height: 230.h,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }

//   String? encodeQueryParameters(Map<String, String> params) {
//     return params.entries
//         .map((MapEntry<String, String> e) =>
//             '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
//         .join('&');
//   }
// }
