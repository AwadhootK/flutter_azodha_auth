// import 'package:azo_auth/bloc/auth_bloc.dart';
// import 'package:azo_auth/core/api_layer/clients/sharedpreferences_client.dart';
// import 'package:azo_auth/core/db/shared_preferences_manager.dart';
// import 'package:azo_auth/core/di/app_dependency_injection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ForgotPinPage extends StatefulWidget {
//   final AuthBloc authBloc;
//   const ForgotPinPage({super.key, required this.authBloc});

//   @override
//   State<ForgotPinPage> createState() => _ForgotPinPageState();
// }

// class _ForgotPinPageState extends State<ForgotPinPage> {
//   SharedPreferencesManager sharedPreferencesManager = AuthDependencyInjector
//       .getIt
//       .get<SharedPreferencesManagerClient>()
//       .sharedPreferencesManager;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<AuthBloc, AuthState>(
//         bloc: widget.authBloc,
//         listenWhen: (previous, current) => current is PinAuthActionState,
//         buildWhen: (previous, current) => current is! PinAuthActionState,
//         listener: (context, state) {
//           if (state is PinLogoutState) {
//             GoRouter.of(context).go(Home.routeName);
//           }
//         },
//         builder: (context, state) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                   child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     '😟',
//                     textAlign: TextAlign.center,
//                     style:
//                         TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'Forgot your password? \nDon’t worry',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.notoSans(
//                         fontSize: 24.sp,
//                         fontWeight: FontWeight.w700,
//                         color: const Color(0xFF161616),
//                         wordSpacing: 2.0),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Text(
//                     'Log in again to reset \nthe new security pin',
//                     style: GoogleFonts.notoSans(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w400,
//                         color: const Color(0xFF161616),
//                         wordSpacing: 2.0),
//                     textAlign: TextAlign.center,
//                   )
//                 ],
//               )),
//               Center(
//                 child: ConstrainedBox(
//                     constraints:
//                         BoxConstraints.tightFor(width: 366.w, height: 62.h),
//                     child: ElevatedButton(
//                         onPressed: () {
//                           sharedPreferencesManager.setPin('');
//                           widget.authBloc.add(AuthLogoutEvent());
//                           Navigator.popUntil(context, (route) => route.isFirst);
//                         },
//                         child: Text(
//                           'Log In Again',
//                           style: GoogleFonts.notoSans(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 16.sp,
//                               color: Colors.white),
//                         ))),
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
