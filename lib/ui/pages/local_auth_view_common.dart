// import 'package:azo_auth/bloc/auth_bloc.dart';
// import 'package:azo_auth/core/api_layer/clients/sharedpreferences_client.dart';
// import 'package:azo_auth/core/db/shared_preferences_manager.dart';
// import 'package:azo_auth/core/di/app_dependency_injection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:logging/logging.dart';

// import 'local_auth_service.dart';

// class LocalAuthViewCommon extends StatelessWidget {
//   final AuthBloc authBloc;
//   LocalAuthViewCommon({Key? key, required this.authBloc}) : super(key: key);
//   static const routeName = '/LocalAuthViewCommon';
//   final SharedPreferencesManager sharedPreferencesManager =
//       AuthDependencyInjector.getIt
//           .get<SharedPreferencesManagerClient>()
//           .sharedPreferencesManager;

//   final log = Logger('LocalAuthViewCommon');
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<AuthBloc, AuthState>(
//         bloc: authBloc,
//         listenWhen: (previous, current) => current is AuthActionState,
//         listener: (context, state) {
//           Navigator.pop(context);
//         },
//         builder: (context, state) {
//           return Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             color: Colors.white,
//             child: SingleChildScrollView(
//               child: Column(
//                 // alignment: Alignment.bottomCenter,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(25.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 35.h),
//                         Container(
//                           width: 95.w,
//                           height: 60.h,
//                           decoration: const BoxDecoration(
//                             image: DecorationImage(
//                                 image: AssetImage(
//                                   'assets/landingimage/ripplelogo.png',
//                                 ),
//                                 fit: BoxFit.fitWidth),
//                           ),
//                         ),
//                         // SizedBox(
//                         //   height: 96.h,
//                         // ),
//                         SizedBox(
//                             // width: 178.w,
//                             child: Text(
//                           Literals.activateLocalAuth,
//                           style: GoogleFonts.notoSans(
//                             fontSize: 24.sp,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         )),
//                         SizedBox(height: 18.h),
//                         Text(
//                           "Login securely with your existing biometric setup",
//                           style: GoogleFonts.notoSans(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(height: 33.h),
//                         Container(
//                           width: 380.w,
//                           height: 355.h,
//                           child:
//                               Image.asset('assets/landingimage/face&touch.png'),
//                         ),
//                         SizedBox(height: 20.h),
//                         ConstrainedBox(
//                           constraints: BoxConstraints.tightFor(
//                               width: 366.w, height: 62.h),
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF424BF9)),
//                             child: Text(
//                               "Enable Biometrics",
//                               style: GoogleFonts.notoSans(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16.sp,
//                               ),
//                             ),
//                             onPressed: () async {
//                               authBloc.add(EnableBiometricsEvent());
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 20.h),
//                         // Center(
//                         //   child: InkWell(
//                         //     child: Text(
//                         //       Literals.skip,
//                         //       style: GoogleFonts.notoSans(
//                         //         fontSize: 16.sp,
//                         //         fontWeight: FontWeight.w500,
//                         //       ),
//                         //     ),
//                         //     onTap: () async {
//                         //       // GoRouter.of(context).push(LocalAuthViewTouch.routeName);
//                         //       GoRouter.of(context).go(Tab1.routeName);
//                         //     },
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   callNotificationPerms(BuildContext context) {
//     //  GoRouter.of(context).go(NotificationPermissionView.routeName);
//   }
// }
