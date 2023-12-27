// import 'package:azo_auth/bloc/auth_bloc.dart';
// import 'package:azo_auth/core/api_layer/clients/sharedpreferences_client.dart';
// import 'package:azo_auth/core/db/shared_preferences_manager.dart';
// import 'package:azo_auth/core/di/app_dependency_injection.dart';
// import 'package:azo_auth/ui/pages/forgot_pin_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pinput/pinput.dart';

// class EnterPinPage extends StatefulWidget {
//   static const routeName = '/enterPin';
//   final AuthBloc authBloc;
//   const EnterPinPage({super.key, required this.authBloc});

//   @override
//   State<EnterPinPage> createState() => _EnterPinPageState();
// }

// class _EnterPinPageState extends State<EnterPinPage> {
//   TextEditingController pinController = TextEditingController();
//   int wrongPasswordCount = 0;
//   SharedPreferencesManager sharedPreferencesManager = AuthDependencyInjector
//       .getIt
//       .get<SharedPreferencesManagerClient>()
//       .sharedPreferencesManager;
//   bool showError = false;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<AuthBloc, AuthState>(
//         bloc: widget.authBloc,
//         listenWhen: (previous, current) =>
//             current is PinVerifiedActionState ||
//             current is PinRejectedActionState,
//         buildWhen: (previous, current) => current is! AuthActionState,
//         listener: (context, state) {
//           if (state is PinVerifiedActionState) {
//             Navigator.popUntil(context, (route) => route.isFirst);
//           } else {
//             if (wrongPasswordCount == 2) {
//               sharedPreferencesManager.setPin('');
//               widget.authBloc.add(AuthLogoutEvent());
//               Navigator.popUntil(context, (route) => route.isFirst);
//             } else {
//               setState(() {
//                 wrongPasswordCount = wrongPasswordCount + 1;
//                 showError = true;
//               });
//             }
//           }
//         },
//         builder: (context, state) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 200,
//                 width: double.maxFinite,
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage(
//                             'assets/landingimage/top_decorator.png'))),
//               ),
//               Expanded(
//                   child: Container(
//                       padding: const EdgeInsets.only(left: 26, right: 26),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Enter your 6-digit PIN',
//                               style: TextStyle(
//                                   fontSize: 24, fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(height: 30),
//                             const Text('Enter PIN'),
//                             const SizedBox(height: 12),
//                             Pinput(
//                               length: 6,
//                               obscureText: true,
//                               obscuringCharacter: '*',
//                               onCompleted: (pin) {
//                                 widget.authBloc
//                                     .add(PinCheckingForAuthEvent(pin: pin));
//                               },
//                               defaultPinTheme: PinTheme(
//                                 width: 56,
//                                 height: 56,
//                                 textStyle: const TextStyle(
//                                     fontSize: 20,
//                                     color: Color.fromRGBO(30, 60, 87, 1),
//                                     fontWeight: FontWeight.w600),
//                                 decoration: BoxDecoration(
//                                   border:
//                                       Border.all(color: Colors.grey.shade300),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               controller: pinController,
//                             ),
//                             SizedBox(height: 10.h),
//                             if (showError)
//                               Column(
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.all(8.h),
//                                     decoration: BoxDecoration(
//                                         color: const Color(0xffFFE9F0),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.warning,
//                                           color: Colors.red,
//                                         ),
//                                         SizedBox(width: 8.h),
//                                         const Expanded(
//                                           child: Text(
//                                               'The PINs you entered do not match. Please check and try again.'),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 10.h),
//                                   Container(
//                                     padding: EdgeInsets.all(8.h),
//                                     decoration: BoxDecoration(
//                                         color: const Color(0xffFFE9F0),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.warning,
//                                           color: Colors.red,
//                                         ),
//                                         SizedBox(width: 8.h),
//                                         Expanded(
//                                           child: Text(
//                                               '${3 - wrongPasswordCount} Attempts left'),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               )
//                           ],
//                         ),
//                       ))),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 20.0),
//                 child: Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ForgotPinPage(
//                                           authBloc: widget.authBloc,
//                                         )));
//                           },
//                           child: const Text(
//                             'Forgot PIN?',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xff3D42ED)),
//                           )),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
